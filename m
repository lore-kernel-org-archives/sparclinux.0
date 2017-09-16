From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Sat, 16 Sep 2017 05:05:58 +0000
Subject: [PATCH] sparc64: Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <201709160505.v8G55wMU011701@aserv0021.oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

(resent due to improper mail agent formatting)

To get a snapshot as complete as possible of what the system is composed of,
this commit adds the ability to retrieve a set of hardware details that are only
available to the ILOM and export them via sysfs to userspace programs and
utilities. Not all the ILOM properties are exposed, only a subset useful to
system utilities.

Communication with the service processor of the ILOM is done via IPMI and VLDC.
This module opens a shell session on the service processor and runs a "show -t"
type of command. The output is then parsed and filtered for the right entries to
populate in one go sysfs at /sys/firmware/ilom

If no shell is available to the module, it will forcibly request one to the
service processor. If the shell it is using got stolen (for example by running
ipmitool while the module is fetching data from the ilom), the module will wait
60s (changeable parameter) and resume from start (it's not possible to pick up
where we previously were).

When the ipmi interface is wrong, the module won't be able to connect to the
service processor. In this case it is possible to amend the interface module
paramenter by writing in sysfs (/sys/module/ilom/parameters/interface) and
the module will use it straight away. When the module is built into the kernel
this should still work.

The "ilom" kernel thread terminates either when data is retrieved from the ILOM
and sysfs populated or when the ilom module is unloaded.

This module must be configured and loaded as module due to a dependency on ipmi
and ipmi_si modules which can't be built into the kernel at the moment.
If this changes in the future the ilom module should build and work when part of
the kernel as well.

Signed-off-by: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
---
 arch/sparc/Kconfig         |   10 +
 arch/sparc/kernel/Makefile |    2 +
 arch/sparc/kernel/ilom.c   |  923 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 935 insertions(+), 0 deletions(-)
 create mode 100644 arch/sparc/kernel/ilom.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index cac67aa..0059f07 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -589,6 +589,16 @@ config SUN_OPENPROMFS
 	  Only choose N if you know in advance that you will not need to modify
 	  OpenPROM settings on the running system.
 
+config ILOM_SYSFS
+	tristate "ILOM support in sysfs"
+	depends on SPARC64 && SYSFS && IPMI_HANDLER && IPMI_SI
+	default y
+	help
+	  Say Y or M here to enable the exporting of some hardware related
+	  data from the ILOM service processor via sysfs. This is useful
+	  to get DIMM details or ROM versions. Exported data is available
+	  under /sys/firmware/ilom when this option is enabled and loaded.
+
 # Makefile helpers
 config SPARC64_PCI
 	bool
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 5e6463d..42005c8 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -120,6 +120,8 @@ obj-$(CONFIG_COMPAT)    += $(audit--y)
 pc--$(CONFIG_PERF_EVENTS) := perf_event.o
 obj-$(CONFIG_SPARC64)	+= $(pc--y)
 
+obj-$(CONFIG_ILOM_SYSFS) += ilom.o
+
 obj-$(CONFIG_UPROBES)	+= uprobes.o
 
 obj-$(CONFIG_SPARC64)	+= jump_label.o
diff --git a/arch/sparc/kernel/ilom.c b/arch/sparc/kernel/ilom.c
new file mode 100644
index 0000000..9de1d44
--- /dev/null
+++ b/arch/sparc/kernel/ilom.c
@@ -0,0 +1,923 @@
+/*
+ * ilom.c - Expose hardware properties of the ILOM to userspace
+ *
+ * Copyright (c) 2016 Oracle and/or its affiliates. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
+ * USA.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/ratelimit.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/ipmi.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+
+#define COMMAND_STR "show -d properties -format nowrap -level all\n"
+
+/* The IPMI interface number can be changed while the module is loaded */
+static unsigned int ipmi_interface;
+module_param_named(interface, ipmi_interface, uint, S_IRUSR | S_IWUSR);
+MODULE_PARM_DESC(interface, "IPMI Interface number (default=0)");
+
+/* maximum number of IPMI retries */
+#define IPMI_RETRIES 3
+
+/* print on the console the time it took to retrieve data from ILOM */
+#define ILOM_PROFILING 0
+
+/* Number of seconds to pause before attempting again, when the IPMI shell has
+ * been forcibly stolen */
+#define IPMI_STOLEN_RETRY_DELAY 60
+
+struct ilom_ipmi {
+	struct ipmi_user_hndl	ipmi_hndlrs;
+
+	struct completion	read_complete;
+	struct ipmi_addr	address;
+	ipmi_user_t		user;
+
+	struct kernel_ipmi_msg	tx_message;
+	long			tx_msgid;
+
+	void			*rx_msg_data;
+	unsigned short		rx_msg_len;
+	unsigned char		rx_result;
+	int			rx_recv_type;
+};
+
+/*
+ * Dispatch IPMI messages to caller(s)
+ */
+static void msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
+{
+	unsigned short rx_len;
+	struct ilom_ipmi *data = (struct ilom_ipmi *) user_msg_data;
+
+	if (msg->msgid != data->tx_msgid) {
+		pr_err_ratelimited("ilom: mismatch between received msgid (%02lx) and transmitted msgid (%02lx)!\n",
+				   msg->msgid, data->tx_msgid);
+		goto handler_cleanup;
+	}
+
+	data->rx_recv_type = msg->recv_type;
+	if (msg->msg.data_len > 0) {
+		data->rx_result = msg->msg.data[0];
+		if (msg->msg.data_len > 1) {
+			rx_len = msg->msg.data_len - 1;
+			if (data->rx_msg_len < rx_len)
+				rx_len = data->rx_msg_len;
+			data->rx_msg_len = rx_len;
+			memcpy(data->rx_msg_data, msg->msg.data + 1,
+			       data->rx_msg_len);
+		} else
+			data->rx_msg_len = 0;
+	} else {
+		data->rx_result = IPMI_UNKNOWN_ERR_COMPLETION_CODE;
+	}
+	complete(&data->read_complete);
+
+handler_cleanup:
+	ipmi_free_recv_msg(msg);
+}
+
+/*
+ * Initialize IPMI address, message buffers and user data
+ */
+static int init_ipmi_data(struct ilom_ipmi *data, int interface)
+{
+	int err;
+
+	data->ipmi_hndlrs.ipmi_recv_hndl = msg_handler;
+
+	init_completion(&data->read_complete);
+
+	/* Initialize IPMI address */
+	data->address.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	data->address.channel = IPMI_BMC_CHANNEL;
+	data->address.data[0] = 0;
+
+	/* Initialize message buffers */
+	data->tx_msgid = 0;
+
+	/* Create IPMI messaging interface user */
+	err = ipmi_create_user(interface, &data->ipmi_hndlrs,
+			       data, &data->user);
+	if (err < 0)
+		pr_err_once("ilom: unable to register user with IPMI interface %d\n",
+			    interface);
+
+	return err;
+}
+
+/*
+ * Send an IPMI command
+ */
+static int send_message(struct ilom_ipmi *data)
+{
+	int err;
+
+	err = ipmi_validate_addr(&data->address, sizeof(data->address));
+	if (err) {
+		pr_debug("ilom: validate_addr=%x\n", err);
+		return err;
+	}
+
+	data->tx_msgid++;
+
+	err = ipmi_request_settime(data->user, &data->address, data->tx_msgid,
+			&data->tx_message, data, 0, 0, 0);
+	if (err) {
+		pr_debug("ilom: request_settime=%x\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/********************
+ * SUNOEM IPMI Code *
+ ********************/
+
+/* Arbitrary timeout in seconds to allow a low-level IPMI command to complete */
+#define IPMI_TIMEOUT		(10 * HZ)
+
+#define IPMI_CC_TIMEOUT		0xc3 /* IPMI completion code */
+
+#define IPMI_NETFN_SUNOEM	0x2e
+#define IPMI_SUNOEM_CLI		0x19
+
+#define SUNOEM_CLI_CMD_OPEN	0 /* Open a new connection */
+#define SUNOEM_CLI_CMD_FORCE	1 /* Close any existing connection, then open */
+#define SUNOEM_CLI_CMD_CLOSE	2 /* Close the current connection */
+#define SUNOEM_CLI_CMD_POLL	3 /* Poll for new data to/from the server */
+#define SUNOEM_CLI_CMD_EOF	4 /* Poll, client is out of data */
+
+#define SUNOEM_CLI_LEGACY_VERSION	1
+#define SUNOEM_CLI_SEQNUM_VERSION	2
+#define SUNOEM_CLI_VERSION		SUNOEM_CLI_SEQNUM_VERSION
+#define SUNOEM_CLI_HEADER		8 /* command + spare + handle */
+#define SUNOEM_CLI_BUF_SIZE		(80 - SUNOEM_CLI_HEADER) /* 80 bytes */
+
+#define SUNOEM_CLI_INVALID_VER_ERR	"Invalid version"
+#define SUNOEM_CLI_BUSY_ERR		"Busy"
+
+struct sunoem_cli_msg {
+	/* Set version to SUNOEM_CLI_VERSION. */
+	uint8_t version;
+
+	/* The command in a request or in a response indicates
+	 * an error if != 0 */
+	uint8_t command_response;
+	uint8_t seqnum;
+	uint8_t spare;
+
+	/* Opaque 4-byte handle, supplied in the response to an OPEN request,
+	 * and used in all subsequent POLL and CLOSE requests */
+	uint8_t handle[4];
+
+	/* The client data in a request, or the server data in a response. Must
+	 * by null terminated, i.e., it must be at least one byte, but can be
+	 * smaller if there's less data */
+	char buf[SUNOEM_CLI_BUF_SIZE];
+} __packed;
+
+static uint8_t sunoem_version = SUNOEM_CLI_VERSION;
+static int sunoem_seqnum;
+
+static int sunoem_open_shell(struct ilom_ipmi *data, int command,
+			     struct sunoem_cli_msg *cli_req,
+			     struct sunoem_cli_msg *cli_rsp)
+{
+	int err;
+
+	memset(cli_req, 0, sizeof(cli_req));
+	cli_req->command_response = command;
+	cli_req->seqnum = sunoem_seqnum;
+
+	data->tx_message.netfn = IPMI_NETFN_SUNOEM;
+	data->tx_message.cmd = IPMI_SUNOEM_CLI;
+	data->tx_message.data = (uint8_t *) cli_req;
+	data->tx_message.data_len = SUNOEM_CLI_HEADER + 1;
+
+	data->rx_msg_data = cli_rsp;
+	data->rx_msg_len = sizeof(*cli_rsp);
+
+	while (1) {
+		cli_req->version = sunoem_version;
+
+		err = send_message(data);
+		if (err)
+			return err;
+
+		err = wait_for_completion_timeout(&data->read_complete,
+						  IPMI_TIMEOUT);
+		if (!err)
+			return -ETIMEDOUT;
+
+		if (data->rx_result)
+			return -ENOENT;
+
+		if (!cli_rsp->command_response)
+			break;
+
+		/* we're in an error condition */
+		if (!strncmp(cli_rsp->buf, SUNOEM_CLI_INVALID_VER_ERR, sizeof(SUNOEM_CLI_INVALID_VER_ERR)-1) ||
+		    !strncmp(cli_rsp->buf+1, SUNOEM_CLI_INVALID_VER_ERR, sizeof(SUNOEM_CLI_INVALID_VER_ERR)-1)) {
+			if (sunoem_version = SUNOEM_CLI_VERSION) {
+				/* Server doesn't support version
+				   SUNOEM_CLI_VERSION Fall back to
+				   legacy version, and try again*/
+				sunoem_version = SUNOEM_CLI_LEGACY_VERSION;
+				continue;
+			}
+			/* Server doesn't support legacy ver either */
+			pr_err("ilom: failed to connect: %*pE\n",
+			       (int) strlen(cli_rsp->buf), cli_rsp->buf);
+			return -ENODEV;
+		}
+
+		if (!strncmp(cli_rsp->buf, SUNOEM_CLI_BUSY_ERR,
+					sizeof(SUNOEM_CLI_BUSY_ERR)-1))
+			return -EBUSY;
+
+		pr_err("ilom: failed to connect: %*pE\n", (int) strlen(cli_rsp->buf), cli_rsp->buf);
+		return -EINVAL;
+	}
+
+	/*
+	 * Bit 1 of seqnum is used as an alternating sequence number
+	 * to allow a server that supports it to detect when a retry is being
+	 * sent from the host IPMI driver. Typically when this occurs, the
+	 * server's last response message would have been dropped. Once the
+	 * server detects this condition, it will know that it should retry
+	 * sending the response */
+	if (sunoem_version = SUNOEM_CLI_SEQNUM_VERSION)
+		sunoem_seqnum ^= 0x1;
+
+	return 0;
+}
+
+static int sunoem_close_shell(struct ilom_ipmi *data,
+			      struct sunoem_cli_msg *cli_req,
+			      struct sunoem_cli_msg *cli_rsp)
+{
+	int err;
+
+	memset(cli_req, 0, sizeof(cli_req));
+	cli_req->command_response = SUNOEM_CLI_CMD_CLOSE;
+	cli_req->seqnum = sunoem_seqnum;
+
+	data->tx_message.netfn = IPMI_NETFN_SUNOEM;
+	data->tx_message.cmd = IPMI_SUNOEM_CLI;
+	data->tx_message.data = (uint8_t *) cli_req;
+	data->tx_message.data_len = SUNOEM_CLI_HEADER + 1;
+
+	data->rx_msg_data = cli_rsp;
+	data->rx_msg_len = sizeof(*cli_rsp);
+
+	err = send_message(data);
+	if (err)
+		return err;
+
+	err = wait_for_completion_timeout(&data->read_complete, IPMI_TIMEOUT);
+	if (!err)
+		return -ETIMEDOUT;
+
+	if (data->rx_result)
+		return -ENOENT;
+
+	return 0;
+}
+
+/*
+ * Sends the command onto the IPMI shell
+ * Commands longer than (SUNOEM_CLI_BUF_SIZE-1) chars are not handled
+ * Also collects a line fragment (console output)
+ */
+static int sunoem_send_recv(struct ilom_ipmi *data,
+			    char *command_str,
+			    struct sunoem_cli_msg *cli_req,
+			    struct sunoem_cli_msg *cli_rsp)
+{
+	int err, retries;
+
+	strcpy(cli_req->buf, command_str);
+	cli_req->version = sunoem_version;
+	cli_req->seqnum = sunoem_seqnum;
+
+	data->tx_message.netfn = IPMI_NETFN_SUNOEM;
+	data->tx_message.cmd = IPMI_SUNOEM_CLI;
+	data->tx_message.data = (uint8_t *) cli_req;
+	data->tx_message.data_len = SUNOEM_CLI_HEADER + strlen(command_str) + 1;
+
+	data->rx_msg_data = cli_rsp;
+	data->rx_msg_len = sizeof(*cli_rsp);
+
+	retries = 0;
+
+	while (1) {
+		err = send_message(data);
+		if (err)
+			return err;
+
+		err = wait_for_completion_timeout(&data->read_complete,
+						  IPMI_TIMEOUT);
+		if (!err)
+			return -ETIMEDOUT;
+
+		if (data->rx_result = IPMI_CC_TIMEOUT) {
+			pr_debug("ilom: failed to poll: %*pE",
+			       (int) strlen(cli_rsp->buf), cli_rsp->buf);
+			if (retries++ < IPMI_RETRIES) {
+				pr_err("ilom: retrying\n");
+				__set_current_state(TASK_INTERRUPTIBLE);
+				schedule_timeout(2 * HZ);
+				continue;
+			}
+			return -EBUSY;
+		}
+		break;
+	}
+
+	if (sunoem_version = SUNOEM_CLI_SEQNUM_VERSION)
+		sunoem_seqnum ^= 0x1;
+	cli_req->seqnum = sunoem_seqnum;
+
+	return 0;
+}
+
+/***********************
+ * ILOM output parsing *
+ ***********************/
+
+/*
+ * Concatenate line to str, increasing allocation of *str if necessary
+ */
+static int concat_string(char **str, char *line, int *size)
+{
+	size_t len_str = strnlen(*str, *size);
+	size_t len_total = len_str + strlen(line) + 1;
+
+	if (len_total > *size) {
+		char *p = krealloc(*str, len_total, GFP_KERNEL);
+
+		if (!p)
+			return -ENOMEM;
+		*str = p;
+	}
+	strcpy(*str + len_str, line);
+	*size = len_total;
+
+	return 0;
+}
+
+/*
+ * Takes a line fragment and fills in a full line (if such has been found)
+ *
+ *          line: The line fragment to parse
+ * line_is_valid: Indicates if line has a valid content
+ *                (which can be NULL if we want to clean-up)
+ *        parsed: If a full line has been found, it will be made available
+ *                in parsed (to be kfreed by the caller)
+ *
+ * Return 0 or and error code
+ */
+static int get_next_line(char *line, int line_is_valid, char **parsed)
+{
+	static char *current_str;
+	static int current_size;
+	char *p;
+
+	if (line_is_valid) {
+		int err;
+
+		/* Clean and kfree things up */
+		if (!line) {
+			if (current_str) {
+				kfree(current_str);
+				current_str = NULL;
+				current_size = 0;
+			}
+			return 0;
+		}
+
+		/* Concatenate line to current_str */
+		err = concat_string(&current_str, line, &current_size);
+		if (err)
+			return err;
+	}
+
+	/* Consume current_str */
+
+	*parsed = NULL;
+
+	/* Ensure first that we've got something to consume */
+	if (!current_str)
+		return 0;
+
+	/* Find the 1st carriage return
+	 * and split strings, using a new allocation */
+	p = strnchr(current_str, current_size, '\n');
+	if (p) {
+		int position = p - current_str;
+		int size_left = current_size - position - 1;
+		char *new = kmalloc(size_left, GFP_KERNEL);
+
+		if (!new)
+			return -ENOMEM;
+
+		*p++ = '\0';
+		memcpy(new, p, size_left);
+		*parsed = current_str;
+		current_str = new;
+		current_size = size_left;
+	}
+	return 0;
+}
+
+/*
+ * Take a line fragment and calls cb() for every property it finds.
+ * The arguments given too cb() are not owned by the callback.
+ *
+ * Return 0 if parsing went okay, or an error otherwise
+ */
+static int parse_show_output(char *line, void (*cb)(char*, char*, char*))
+{
+	static int in_properties;
+	static char *key;
+	int line_is_valid = 1;
+	char *parsed = NULL;
+
+	do {
+		int result;
+		char *p;
+
+		result = get_next_line(line, line_is_valid, &parsed);
+
+		if (result) {
+			pr_debug("ilom: an error occured while parsing %*pE\n",
+				 (int) strlen(parsed), parsed);
+			get_next_line(NULL, 1, NULL); /* cleanup */
+			return result;
+		}
+
+		line_is_valid = 0;
+
+		if (!parsed)
+			continue;
+
+		if (*parsed = ' ') {
+			/* skip leading spaces */
+			for (p = parsed; *p = ' '; )
+				p++;
+
+			if (*p = '/') {
+				key = kstrdup(p, GFP_KERNEL);
+				in_properties = 1;
+			} else if (!strncmp(p, "Properties", 10)) {
+				/* discard */
+			} else {
+				if (in_properties && (key)) {
+					char *sep = strstr(p, " = ");
+
+					if (sep) {
+						*sep = '\0';
+						cb(key, p, sep + 3);
+						/* above: 3 = strlen(" = ") */
+					}
+				} else {
+					pr_debug("ilom: property in invalid block: %s\n", p);
+				}
+			}
+		} else if (*parsed = '\0') {
+			in_properties = 0;
+			if (key) {
+				kfree(key);
+				key = NULL;
+			}
+		} else if (!strcmp(parsed, "Disconnected")) {
+			/* end of stream marker
+			 * nothing to do, really */
+		} else if (!strncmp(parsed, "-> ", 3)) {
+			/* discard */
+		}  else {
+			pr_debug("ilom: unparsed: %*pE\n",
+			       (int) strlen(parsed), parsed);
+		}
+		kfree(parsed);
+	} while (parsed);
+
+	return 0;
+}
+
+/**************
+ * Sysfs Code *
+ **************/
+
+struct sysfs_property {
+	struct kobj_attribute kattr;
+	char *value;
+};
+
+ssize_t ilom_sysfs_show(struct kobject *object,
+			struct kobj_attribute *attr, char *buf)
+{
+	struct sysfs_property *prop;
+
+	prop = container_of(attr, struct sysfs_property, kattr);
+	return sprintf(buf, "%s\n", prop->value);
+}
+
+struct kobject *ilom_kobj;
+static struct attribute **sysfs_attributes;
+static int sysfs_attributes_length;
+
+/*
+ * Append a property to the list that will be later
+ * passed to sysfs_create_files()
+ */
+static int add_property(struct sysfs_property *prop)
+{
+	static int size;   /* how much we've allocated */
+	struct attribute **p;
+
+	if (size <= (sysfs_attributes_length + 1)) {
+		size += 16; /* pre-allocation to relieve the allocator */
+		p = krealloc(sysfs_attributes, size * sizeof(*sysfs_attributes),
+			     GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+
+		sysfs_attributes = p;
+	}
+	sysfs_attributes[sysfs_attributes_length++] = &prop->kattr.attr;
+	/* the array must be NULL terminated */
+	sysfs_attributes[sysfs_attributes_length] = NULL;
+	return 0;
+}
+
+/*
+ * Helper function to make populate_sysfs() more readable
+ * returns true if target starts with prefix
+ */
+static inline bool starts_with(char *target, char *prefix)
+{
+	return !strncmp(target, prefix, strlen(prefix));
+}
+
+/*
+ * Helper function to make populate_sysfs() more readable
+ * returns true if s1 and s2 are equal
+ */
+static inline bool equals(char *s1, char *s2)
+{
+	return !strcmp(s1, s2);
+}
+
+/*
+ * Helper function to make populate_sysfs() more readable
+ * return true if haystack contains needle
+ */
+static inline bool contains(char *haystack, char *needle)
+{
+	return strstr(haystack, needle) != NULL;
+}
+
+/*
+ * Match interesting entries and add them to sysfs_attributes
+ */
+void populate_sysfs(char *key, char *property, char *value)
+{
+	/* filter the keys we're interested in */
+	if (starts_with(key, "/System/Memory/DIMMs/DIMM_") ||
+	    starts_with(key, "/System/Firmware/Other_Firmware/Firmware_") ||
+	    starts_with(key, "/System/Processors/CPUs/CPU_") ||
+	    equals(key, "/System") ||
+	    equals(key, "/SYS") ||
+	    equals(key, "/SYS/MB") ||
+	    equals(key, "/SYS/MB/SP") ||
+	    equals(key, "/SYS/MB_ENV"))
+	{
+		struct sysfs_property *prop;
+		char *sprop = NULL;
+
+		/* filter-out sensor type properties */
+		if (starts_with(property, "actual_") ||
+		    starts_with(property, "health") ||
+		    equals(property, "action") ||
+		    equals(property, "temperature") ||
+		    contains(property, "fault"))
+			return;
+
+		prop = kmalloc(sizeof(*prop), GFP_KERNEL);
+		if (prop)
+			sprop = kmalloc(strlen(key) + strlen(property) + 1,
+					GFP_KERNEL);
+		if (!sprop) {
+			kfree(prop);
+			return;
+		}
+
+		/* Set the name */
+		prop->kattr.attr.name = sprop;
+		for (key++; *key; key++)
+			*sprop++ = (*key = '/' ? '-' : *key);
+		*sprop++ = '-'; /* no worries there's enough space */
+		strcpy(sprop, property);
+
+		prop->kattr.attr.mode = VERIFY_OCTAL_PERMISSIONS(S_IRUSR);
+		prop->kattr.show = ilom_sysfs_show;
+		prop->kattr.store = NULL;
+		prop->value = kstrdup(value, GFP_KERNEL);
+
+		add_property(prop);
+	}
+}
+
+/*
+ * Create /sys/firmware/ilom and adds to it the attributes that we've been
+ * collecting while parsing the ILOM shell output.
+ * the argument passed is effectively sysfs_attributes
+ */
+void ilom_add_to_sysfs(struct attribute **attributes)
+{
+	const struct attribute **pattr = (const struct attribute **) attributes;
+	int err;
+
+	ilom_kobj = kobject_create_and_add("ilom", firmware_kobj);
+	if (!ilom_kobj) {
+		pr_err("ilom: unable to create sysfs entry\n");
+		return;
+	}
+	if (attributes) {
+		err = sysfs_create_files(ilom_kobj, pattr);
+		if (err) {
+			pr_err("ilom: unable to create sysfs properties\n");
+			kobject_put(ilom_kobj);
+		}
+	}
+}
+
+/*
+ * Called when the IPMI shell has been interrupted, either consecutively to the
+ * ipmi shell being stolen or when we quit the control loop (because the module
+ * is unloaded or the IPMI layer returned an error
+ */
+static void cleanup_existing_attributes(struct attribute **attributes)
+{
+	struct attribute **attr;
+
+	if (!sysfs_attributes)
+		return;
+
+	for (attr = attributes; *attr; attr++) {
+		struct sysfs_property *prop;
+
+		prop = container_of(*attr, struct sysfs_property, kattr.attr);
+		kfree(prop);
+		sysfs_attributes_length--;
+	}
+	WARN_ON(sysfs_attributes_length != 0);
+}
+
+/*********************
+ * Top-level routine *
+ *********************/
+
+#define ILOM_IPMI_RUN_SUCCESS	0
+#define ILOM_IPMI_RUN_STOLEN	-1
+#define ILOM_IPMI_RUN_FAILURE	-2
+
+/*
+ * Run a command on the ilom (must be a show type of command)
+ * Collects and parse the output, creating an array of sysfs attribute objects
+ * suitable for sysfs_create_files()
+ */
+static int ipmi_run_command(struct ilom_ipmi *data, const char *command_str)
+{
+	struct sunoem_cli_msg cli_req;
+	struct sunoem_cli_msg cli_rsp;
+	int command = SUNOEM_CLI_CMD_OPEN;
+	char *str_command = (char *) command_str;
+	int err;
+
+	/* Open IPMI */
+	do {
+		/* pick-up the latest value for the `interface' module parameter
+		 * written into sysfs */
+		err = init_ipmi_data(data, ipmi_interface);
+		if (kthread_should_stop())
+			goto ipmi_run_end;
+		__set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+	} while (err);
+
+	/* Create an ilom shell session */
+	do {
+		err = sunoem_open_shell(data, command, &cli_req, &cli_rsp);
+		if (kthread_should_stop()) {
+			err = ILOM_IPMI_RUN_FAILURE;
+			goto ipmi_run_cleanup;
+		}
+		/* sunoem CLI could be denied because all session slots appear
+		 * to be busy. Starting with Oracle ILOM 3.0.10 the FORCE
+		 * command closes any currently running IPMI sunoem CLI session
+		 * in favor of the new one that is being invoked. See:
+		 * https://docs.oracle.com/cd/E19860-01/E21549/z400054d1023430.html */
+		command = SUNOEM_CLI_CMD_FORCE;
+		__set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+	} while (err);
+
+	/* Remember the handle provided in the response, and issue a
+	 * series of "poll" commands to send and get data */
+	memcpy(cli_req.handle, cli_rsp.handle, 4);
+	cli_req.command_response = SUNOEM_CLI_CMD_POLL;
+	do {
+		if (kthread_should_stop()) {
+			err = sunoem_close_shell(data, &cli_req, &cli_rsp);
+			if (err) {
+				pr_debug("ilom: unable to close ilom shell\n");
+				/* indicate that we haven't done all the work */
+				err = ILOM_IPMI_RUN_FAILURE;
+				goto ipmi_run_cleanup;
+			}
+		}
+		err = sunoem_send_recv(data, str_command, &cli_req, &cli_rsp);
+		if (err) {
+			pr_err("ilom: communication issue: %d\n", err);
+			ipmi_destroy_user(data->user);
+			err = ILOM_IPMI_RUN_FAILURE;
+			goto ipmi_run_cleanup;
+		}
+		cli_rsp.buf[sizeof(cli_rsp.buf)-1] = '\0';
+		if (*cli_rsp.buf) {
+			err = parse_show_output(cli_rsp.buf, populate_sysfs);
+			if (err)
+				pr_err("ilom: parse error %d\n", err);
+		}
+		if ((cli_req.command_response = SUNOEM_CLI_CMD_EOF) &&
+		    cli_rsp.command_response)
+			break;
+
+		str_command = "";
+		cli_req.command_response = SUNOEM_CLI_CMD_EOF;
+	} while (!cli_rsp.command_response);
+
+	err = ILOM_IPMI_RUN_SUCCESS;
+
+	/* clean-up allocations */
+	parse_show_output(NULL, populate_sysfs);
+	if (cli_rsp.command_response) {
+		if (cli_rsp.command_response = SUNOEM_CLI_CMD_CLOSE) {
+			pr_err("ilom: sunoem cli session stolen!\n");
+			err = ILOM_IPMI_RUN_STOLEN;
+		} else if (cli_rsp.command_response != 1) {
+			pr_err("ilom: failed to retrieve data\n");
+			err = ILOM_IPMI_RUN_FAILURE;
+		}
+	}
+
+ipmi_run_cleanup:
+	ipmi_destroy_user(data->user);
+
+ipmi_run_end:
+	return err;
+}
+
+/*****************
+ * Kernel Thread *
+ *****************/
+
+struct ilom_data {
+	struct task_struct *kworker;
+	struct ilom_ipmi    ipmi_data;
+};
+
+static struct ilom_data priv_data;
+
+/*
+ * The kernel thread named "ilom"
+ */
+static int thread_function(void *thread_data)
+{
+#ifdef PROFILING_PARAM
+	struct timespec start_time = {0};
+#endif
+	struct ilom_ipmi *ipmi = (struct ilom_ipmi *) thread_data;
+	const char *command_str = COMMAND_STR;
+	int err = 0;
+
+#if ILOM_PROFILING
+	start_time = current_kernel_time();
+#endif
+
+	/* calling ipmi_run_command() with the string to execute
+	 * we allocate a kobject beforehand, then insert it in sysfs if the
+	 * call succeeds.
+	 * If the IPMI console is stolen we wait IPMI_STOLEN_RETRY_DELAY
+	 * seconds, allowing for rmmod to remove the module during the delay
+	 * Any other error is deemed serious so we don't retry */
+	while (!kthread_should_stop()) {
+
+		cleanup_existing_attributes(sysfs_attributes);
+		err = ipmi_run_command(ipmi, command_str);
+		if (!err) {
+			ilom_add_to_sysfs(sysfs_attributes);
+			break;
+		}
+
+		if (err = ILOM_IPMI_RUN_STOLEN) {
+			__set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(IPMI_STOLEN_RETRY_DELAY * HZ);
+		}
+	}
+
+#if ILOM_PROFILING
+	{
+		struct timespec end_time = current_kernel_time();
+		struct timespec diff = timespec_sub(end_time, start_time);
+
+		pr_info("ilom: took %lds to retrieve data from ILOM\n",
+		       diff.tv_sec);
+	}
+#endif
+
+	/* As commented in kthread_stop(), the thread function can call
+	 * do_exit(), as long at it ensures the task_struct doesn't go away.
+	 * Basically only one call to get_task_struct() call occured (in
+	 * kthread_create()) but both do_exit() and kthread_stop() call
+	 * put_task_struct()
+	 *
+	 * So what we need to do to make sure the task_struct is still there
+	 * when we'll be calling kthread_stop() at module removal is bumping
+	 * the task_struct usage count by calling get_task_struct() */
+	get_task_struct(priv_data.kworker);
+	do_exit(err);
+}
+
+/***********************
+ * Module related code *
+ ***********************/
+
+MODULE_DESCRIPTION("Expose hardware properties of the ILOM to userspace");
+MODULE_AUTHOR("Oracle");
+MODULE_LICENSE("GPL");
+
+#if !IPMI_STOLEN_RETRY_DELAY
+#error "IPMI_STOLEN_RETRY_DELAY can't be zero!"
+#endif
+
+static int __init ilom_init(void)
+{
+	struct task_struct *task;
+
+	if (strlen(COMMAND_STR) > SUNOEM_CLI_BUF_SIZE-1) {
+		pr_err("ilom: shell command string too big\n");
+		return -EINVAL;
+	}
+
+	memset(&priv_data, 0, sizeof(priv_data));
+	task = kthread_create(&thread_function, (void *) &priv_data.ipmi_data,
+			      "ilom");
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	priv_data.kworker = task;
+	wake_up_process(task);
+
+	return 0;
+}
+
+static void __exit ilom_cleanup(void)
+{
+	kthread_stop(priv_data.kworker);
+	if (ilom_kobj) {
+		kobject_del(ilom_kobj);
+		kobject_put(ilom_kobj);
+	}
+
+	if (sysfs_attributes) {
+		cleanup_existing_attributes(sysfs_attributes);
+		kfree(sysfs_attributes);
+	}
+}
+
+module_init(ilom_init);
+module_exit(ilom_cleanup);
-- 
1.7.1

