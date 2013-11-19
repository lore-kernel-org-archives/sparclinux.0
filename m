From: Peter Hurley <peter@hurleysoftware.com>
Date: Tue, 19 Nov 2013 14:23:26 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <528B745E.7050801@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/18/2013 10:46 AM, Meelis Roos wrote:
>>> First I compared the configurations of working and nonworking machines
>>> (there were 2 different machines from the same era with problem), then
>>> did some conf bisecting and found that CONFIG_SUN_OPENPROMFS causes the
>>> RED problem in 3.12-rc5 when compiled modular and module loaded. It did
>>> not happen when it was compiled statically, or modular but module was
>>> not loaded. Reduced minimalistic configuration that causes this on Ultra
>>> 5 is attached to this mail.

Is the problem unique to these 2 machines given this configuration, or is
the problem reproduceable on other machines using this configuration?

>>> With the minimalistic conf, I redid the bisect with a different range
>>> end, fixing vmalloc.h include when needed. This led me into tty changes
>>> again, maybe more precise this time because of vmalloc fixes (no commits
>>> skipped this time). This is the culprit today:
>>>
>>> 20bafb3d23d108bc0a896eb8b7c1501f4f649b77 is the first bad commit
>>> commit 20bafb3d23d108bc0a896eb8b7c1501f4f649b77
>>> Author: Peter Hurley <peter@hurleysoftware.com>
>>> Date:   Sat Jun 15 10:21:19 2013 -0400
>>>
>>>       n_tty: Move buffers into n_tty_data
>>>
>>>       Reduce pointer reloading and improve locality-of-reference;
>>>       allocate read_buf and echo_buf within struct n_tty_data.
>>>
>>>       Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>>>       Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> :040000 040000 96d92e4e242c4b2ff11b25c005bccd093865b350
>>> 2822d87b2425c3e7adc7b722a20d739c9d4a3046 M      drivers
>>>
>>> This patch seems to switch ldata with its read_buf and echo_buf from
>>> kmalloc/kfree to vmalloc/vfree (the bufs are now inlined in ldata, not
>>> separately allocated).
>>
>> Yep, this makes more sense than the original bisect.
>>
>>> More fields in ldata are now explicitly initialized to zero instead of
>>> kzalloc doing it before. However, I do not see the initialization of
>>> some of the fields - maybe they are done later in the code? I noticed
>>> process_char_map, raw, real_raw, icanon, read_buf, echo_buf that were
>>> zeroed before but I did not find explicit zeroing of them after the
>>> patch. However, just adding a memset to zero ldata after vmalloc does
>>> not change anything.
>>>
>>> Openpromfs does not seem to be changed after 3.11 and it does not seem
>>> to use any tty layer functions.
>>>
>>> I still have no idea how it would interact.
>>
>> Me neither. But it looks like something depends on tty working before
>> the mmu is initialized. David, would you know what that is?
>
> It happens on the shutdown part of reboot, not startup - when we call
> prom "boot" command, it should output "Resetting ..." and reset but
> never outputs anything, then RED state exeption occurs. To the best of
> my understanding, Linux does not output anything any more at that point,
> only prom. Have we hooked into prom somehow? Openpromfs itselt just
> seems to read the in-memory data structures of device tree.



> Another strange symptom is that the problem did not happen when
> openpromfs is compiled in statically, not loaded as module. When loaded
> as module, its memory is vmalloc()ed... but that's probably too weak
> connection to conclude anything.

What happens with the not-even-compile-tested debug patch below?

--->%---
Subject: [PATCH] Debug instrumentation of exit_openprom_fs()


Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
  fs/openpromfs/inode.c | 7 +++++++
  1 file changed, 7 insertions(+)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 8c0ceb8..9fc4c86 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -12,12 +12,15 @@
  #include <linux/slab.h>
  #include <linux/seq_file.h>
  #include <linux/magic.h>
+#include <linux/printk.h>

  #include <asm/openprom.h>
  #include <asm/oplib.h>
  #include <asm/prom.h>
  #include <asm/uaccess.h>

+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
  static DEFINE_MUTEX(op_mutex);

  #define OPENPROM_ROOT_INO	0
@@ -456,6 +459,8 @@ static int __init init_openprom_fs(void)

  static void __exit exit_openprom_fs(void)
  {
+	pr_info("exiting\n");
+
  	unregister_filesystem(&openprom_fs_type);
  	/*
  	 * Make sure all delayed rcu free inodes are flushed before we
@@ -463,6 +468,8 @@ static void __exit exit_openprom_fs(void)
  	 */
  	rcu_barrier();
  	kmem_cache_destroy(op_inode_cachep);
+
+	pr_info("exited\n");
  }

  module_init(init_openprom_fs)
-- 
1.8.1.2



