From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 20 Nov 2012 02:45:10 +0000
Subject: [Suggestion]  arch/sparc: change full_boot_str[256] to full_boot_str[COMMAND_LINE_SIZE + sizeof ("bo
Message-Id: <50AAEEB6.9070704@asianux.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Sam and David:

Excuse me, my English is truly not quite well, maybe what I said is not politeness, originally.

I am scanning strcpy for whole kernel, and currently at arch/sparc/kernel/ds.c:904:
I suggest the full_boot_str[256] changes to full_boot_str[COMMAND_LINE_SIZE + sizeof ("boot ")] at line 834
for strcpy at line 846
   arch/sparc/include/uapi/asm/setup.h:  boot command parameter's length should be within COMMAND_LINE_SIZE (2048, or 256)
   kernel/sys.c:377:  call machine_restart (the command length is less than 256, maybe 255 + '\0')
   so full_boot_str need be COMMAND_LINE_SIZE + sizeof ("boot "), at least. 

hope the suggestion is useful for you.

thanks.


 834 static char full_boot_str[256] __attribute__((aligned(32)));
 835 static int reboot_data_supported;
 836 
 837 void ldom_reboot(const char *boot_command)
 838 {
 839         /* Don't bother with any of this if the boot_command
 840          * is empty.
 841          */
 842         if (boot_command && strlen(boot_command)) {
 843                 unsigned long len;
 844 
 845                 strcpy(full_boot_str, "boot ");
 846                 strcpy(full_boot_str + strlen("boot "), boot_command);
 847                 len = strlen(full_boot_str);
 848 
 849                 if (reboot_data_supported) {
 850                         unsigned long ra = kimage_addr_to_ra(full_boot_str);
 851                         unsigned long hv_ret;
 852 
 853                         hv_ret = sun4v_reboot_data_set(ra, len);
 854                         if (hv_ret != HV_EOK)
 855                                 pr_err("SUN4V: Unable to set reboot data "
 856                                        "hv_ret=%lu\n", hv_ret);
 857                 } else {
 858                         ldom_set_var("reboot-command", full_boot_str);
 859                 }
 860         }
 861         sun4v_mach_sir();
 862 }

-- 
Chen Gang

Asianux Corporation
