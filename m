From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 08 Nov 2019 20:34:31 +0000
Subject: [PATCH 8/8] Input: input_event: fix struct padding on sparc64
Message-Id: <20191108203435.112759-9-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20191108203435.112759-1-arnd@arndb.de>
In-Reply-To: <20191108203435.112759-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-input@vger.kernel.org

Going through all uses of timeval, I noticed that we screwed up
input_event in the previous attempts to fix it:

The time fields now match between kernel and user space, but
all following fields are in the wrong place.

Add the required padding that is implied by the glibc timeval
definition to fix the layout, and add explicit initialization
to avoid leaking kernel stack data.

Cc: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: stable@vger.kernel.org
Fixes: 141e5dcaa735 ("Input: input_event - fix the CONFIG_SPARC64 mixup")
Fixes: 2e746942ebac ("Input: input_event - provide override for sparc64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/evdev.c       | 3 +++
 drivers/input/misc/uinput.c | 3 +++
 include/uapi/linux/input.h  | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index d7dd6fcf2db0..24a90793caf0 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -228,6 +228,9 @@ static void __pass_event(struct evdev_client *client,
 						event->input_event_sec;
 		client->buffer[client->tail].input_event_usec  						event->input_event_usec;
+#ifdef CONFIG_SPARC64
+		client->buffer[client->tail].__pad = 0;
+#endif
 		client->buffer[client->tail].type = EV_SYN;
 		client->buffer[client->tail].code = SYN_DROPPED;
 		client->buffer[client->tail].value = 0;
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 84051f20b18a..1d8c09e9fd47 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -80,6 +80,9 @@ static int uinput_dev_event(struct input_dev *dev,
 	ktime_get_ts64(&ts);
 	udev->buff[udev->head].input_event_sec = ts.tv_sec;
 	udev->buff[udev->head].input_event_usec = ts.tv_nsec / NSEC_PER_USEC;
+#ifdef CONFIG_SPARC64
+	udev->buff[udev->head].__pad = 0;
+#endif
 	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
 
 	wake_up_interruptible(&udev->waitq);
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index f056b2a00d5c..9a61c28ed3ae 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -34,6 +34,7 @@ struct input_event {
 	__kernel_ulong_t __sec;
 #if defined(__sparc__) && defined(__arch64__)
 	unsigned int __usec;
+	unsigned int __pad;
 #else
 	__kernel_ulong_t __usec;
 #endif
-- 
2.20.0
