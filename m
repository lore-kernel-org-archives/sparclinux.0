From: sjoerd@spring.luon.net (Sjoerd Simons)
Date: Sat, 20 Nov 2004 15:50:58 +0000
Subject: Re: ioct32 bit compatibilty questions
Message-Id: <20041120155058.GA17661@spring.luon.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
List-Id: <sparclinux.vger.kernel.org>
References: <20041111110024.GA8836@spring.luon.net>
In-Reply-To: <20041111110024.GA8836@spring.luon.net>
To: sparclinux@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 20, 2004 at 04:47:08PM +0100, Sjoerd Simons wrote:
> Patch attached against linux 2.6.9. I haven't done a lot of kernel hacking, so
> any comments are very welcome! 

Ofcourse i forgot to actually attach it. Second try :)

  Sjoerd
-- 
What is wanted is not the will to believe, but the will to find out,
which is the exact opposite.
		-- Bertrand Russell, "Skeptical Essays", 1928

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sparc-alsa-2.6.9.patch"

diff -aur linux-2.6.9/sound/core/ioctl32/hwdep32.c linux-2.6.9-alsa32/sound/core/ioctl32/hwdep32.c
--- linux-2.6.9/sound/core/ioctl32/hwdep32.c	2004-10-18 23:55:21.000000000 +0200
+++ linux-2.6.9-alsa32/sound/core/ioctl32/hwdep32.c	2004-11-20 13:44:48.000000000 +0100
@@ -40,19 +40,33 @@
 	struct sndrv_hwdep_dsp_image32 data32;
 	mm_segment_t oldseg;
 	int err;
+  void *image = NULL;
 
 	if (copy_from_user(&data32, (void __user *)arg, sizeof(data32)))
 		return -EFAULT;
+  image = kmalloc(data32.length, GFP_KERNEL); 
+  if (image == NULL) {
+    err = -ENOMEM;
+    goto __dsp_image_out;
+  }
+  if (copy_from_user(image, (void __user *)compat_ptr(data32.image), 
+                     data32.length)) {
+    err = -EFAULT;
+    goto __dsp_image_out;
+  }
 	memset(&data, 0, sizeof(data));
 	data.index = data32.index;
 	memcpy(data.name, data32.name, sizeof(data.name));
-	data.image = compat_ptr(data32.image);
+	data.image = image;
 	data.length = data32.length;
 	data.driver_data = data32.driver_data;
 	oldseg = get_fs();
 	set_fs(KERNEL_DS);
 	err = file->f_op->ioctl(file->f_dentry->d_inode, file, native_ctl, (unsigned long)&data);
 	set_fs(oldseg);
+
+__dsp_image_out:
+  kfree(image);
 	return err;
 }
 
diff -aur linux-2.6.9/sound/core/ioctl32/ioctl32.c linux-2.6.9-alsa32/sound/core/ioctl32/ioctl32.c
--- linux-2.6.9/sound/core/ioctl32/ioctl32.c	2004-10-18 23:53:21.000000000 +0200
+++ linux-2.6.9-alsa32/sound/core/ioctl32/ioctl32.c	2004-11-20 13:43:41.000000000 +0100
@@ -24,11 +24,13 @@
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/slab.h>
+#include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <asm/uaccess.h>
 #include "ioctl32.h"
+#include <sound/control.h>
 
 /*
  * register/unregister mappers
@@ -93,21 +95,13 @@
 	unsigned char reserved[50];
 } /* don't set packed attribute here */;
 
-#define CVT_sndrv_ctl_elem_list()\
-{\
-	COPY(offset);\
-	COPY(space);\
-	COPY(used);\
-	COPY(count);\
-	CPTR(pids);\
-}
-
 static int _snd_ioctl32_ctl_elem_list(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file, unsigned int native_ctl)
 {
 	struct sndrv_ctl_elem_list32 data32;
 	struct sndrv_ctl_elem_list data;
+  snd_ctl_elem_id_t *dst = NULL;
 	mm_segment_t oldseg;
-	int err;
+	int err = 0;
 
 	if (copy_from_user(&data32, (void __user *)arg, sizeof(data32)))
 		return -EFAULT;
@@ -116,22 +110,36 @@
 	data.space = data32.space;
 	data.used = data32.used;
 	data.count = data32.count;
-	data.pids = compat_ptr(data32.pids);
+  if (data.space) {
+    dst = kmalloc(data.space * sizeof(snd_ctl_elem_id_t), GFP_KERNEL);
+    if (dst == NULL) {
+      return -ENOMEM;
+    }
+  }
+	data.pids = dst;
 	oldseg = get_fs();
 	set_fs(KERNEL_DS);
-	err = file->f_op->ioctl(file->f_dentry->d_inode, file, native_ctl, (unsigned long)&data);
+  err = sys_ioctl(fd, native_ctl, (unsigned long) &data);
 	set_fs(oldseg);
-	if (err < 0)
-		return err;
+	if (err < 0) {
+    goto __list_end;
+  }
+  if (data.used > 0 && 
+      copy_to_user(compat_ptr(data32.pids),
+                   dst, data.used * sizeof(snd_ctl_elem_id_t))) {
+    err = -EFAULT;
+    goto __list_end;
+  }
 	/* copy the result */
 	data32.offset = data.offset;
 	data32.space = data.space;
 	data32.used = data.used;
 	data32.count = data.count;
-	//data.pids = data.pids;
 	if (copy_to_user((void __user *)arg, &data32, sizeof(data32)))
-		return -EFAULT;
-	return 0;
+		err = -EFAULT;
+__list_end:
+  kfree(dst);
+	return err;
 }
 
 DEFINE_ALSA_IOCTL_ENTRY(ctl_elem_list, ctl_elem_list, SNDRV_CTL_IOCTL_ELEM_LIST);
@@ -246,7 +254,7 @@
 		struct sndrv_aes_iec958 iec958;
         } value;
         unsigned char reserved[128];
-} __attribute__((packed));
+}; // __attribute__((packed));
 
 
 /* hmm, it's so hard to retrieve the value type from the control id.. */
@@ -280,6 +288,7 @@
 	struct sndrv_ctl_elem_value32 *data32;
 	int err, i;
 	int type;
+  void *indirect = NULL;
 	mm_segment_t oldseg;
 
 	/* FIXME: check the sane ioctl.. */
@@ -298,8 +307,12 @@
 	memset(data, 0, sizeof(*data));
 	data->id = data32->id;
 	data->indirect = data32->indirect;
-	if (data->indirect) /* FIXME: this is not correct for long arrays */
-		data->value.integer.value_ptr = compat_ptr(data32->value.integer.value_ptr);
+	if (data->indirect) { /* FIXME: this is not correct for long arrays */
+    /* FIXME Broken because in get_fs() == KERNEL_DS all __user pointers should
+     * be in kernel space */
+    err = -EINVAL;
+    goto __end;
+  }
 	type = get_ctl_type(file, &data->id);
 	if (type < 0) {
 		err = type;
@@ -374,6 +387,7 @@
       		kfree(data32);
 	if (data)
 		kfree(data);
+  kfree(indirect);
 	return err;
 }
 
diff -aur linux-2.6.9/sound/core/ioctl32/ioctl32.h linux-2.6.9-alsa32/sound/core/ioctl32/ioctl32.h
--- linux-2.6.9/sound/core/ioctl32/ioctl32.h	2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6.9-alsa32/sound/core/ioctl32/ioctl32.h	2004-11-20 12:20:15.000000000 +0100
@@ -29,7 +29,6 @@
 #include <linux/compat.h>
 
 #define COPY(x)  (dst->x = src->x)
-#define CPTR(x)	 (dst->x = compat_ptr(src->x))
 
 #define convert_from_32(type, dstp, srcp)\
 {\
diff -aur linux-2.6.9/sound/core/ioctl32/pcm32.c linux-2.6.9-alsa32/sound/core/ioctl32/pcm32.c
--- linux-2.6.9/sound/core/ioctl32/pcm32.c	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6.9-alsa32/sound/core/ioctl32/pcm32.c	2004-11-20 13:44:30.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
+#include <linux/syscalls.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include "ioctl32.h"
@@ -187,25 +188,41 @@
 	struct sndrv_xferi32 data32;
 	struct sndrv_xferi data;
 	mm_segment_t oldseg;
-	int err;
+	int err = 0;
+  void *buffer = NULL;
+  snd_pcm_substream_t *substream;
+  snd_pcm_runtime_t *runtime;
+  size_t size;
+
+  substream = ((snd_pcm_file_t *)file->private_data)->substream;
+  snd_assert(substream != NULL, return -ENXIO);
+  runtime = substream->runtime;
 
 	if (copy_from_user(&data32, (void __user *)arg, sizeof(data32)))
 		return -EFAULT;
 	memset(&data, 0, sizeof(data));
+  size = frames_to_bytes(runtime, data32.frames);
+  buffer = kmalloc(size, GFP_KERNEL);
+  if (copy_from_user(buffer, (void __user *)compat_ptr(data32.buf), size)) {
+    err = -EFAULT;
+    goto __xferi_end;
+  }
 	data.result = data32.result;
-	data.buf = compat_ptr(data32.buf);
+	data.buf = buffer;
 	data.frames = data32.frames;
 	oldseg = get_fs();
 	set_fs(KERNEL_DS);
-	err = file->f_op->ioctl(file->f_dentry->d_inode, file, native_ctl, (unsigned long)&data);
+  err = sys_ioctl(fd, native_ctl, (unsigned long) &data);
 	set_fs(oldseg);
 	if (err < 0)
-		return err;
+		goto __xferi_end;
 	/* copy the result */
 	data32.result = data.result;
 	if (copy_to_user((void __user *)arg, &data32, sizeof(data32)))
-		return -EFAULT;
-	return 0;
+		err = -EFAULT;
+__xferi_end:
+  kfree(buffer);
+	return err;
 }
 
 
@@ -229,12 +246,12 @@
 	struct sndrv_xfern32 data32;
 	struct sndrv_xfern32 __user *srcptr = (void __user *)arg;
 	void __user **bufs = NULL;
-	int err = 0, ch, i;
+	int err = 0, ch, i, cp = 0;
 	u32 __user *bufptr;
 	mm_segment_t oldseg;
+  size_t size;
 
 	/* FIXME: need to check whether fop->ioctl is sane */
-
 	pcm_file = file->private_data;
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL && substream->runtime, return -ENXIO);
@@ -261,12 +278,26 @@
 	bufs = kmalloc(sizeof(void *) * 128, GFP_KERNEL);
 	if (bufs == NULL)
 		return -ENOMEM;
+  size = frames_to_bytes(substream->runtime , data32.frames);
 	for (i = 0; i < ch; i++) {
 		u32 ptr;
-		if (get_user(ptr, bufptr))
-			return -EFAULT;
-		bufs[ch] = compat_ptr(ptr);
+    void *buf;
+		if (get_user(ptr, bufptr)) {
+			err = -EFAULT;
+      goto __xfern_out;
+    }
+		buf = kmalloc(size, GFP_KERNEL);
+    if (buf == NULL) {
+      err = -ENOMEM;
+      goto __xfern_out;
+    }
+    if (copy_from_user(buf, (void __user *)compat_ptr(ptr), size)) {
+      err = -EFAULT;
+      goto __xfern_out;
+    }
+    bufs[i] = buf;
 		bufptr++;
+    cp++;
 	}
 	oldseg = get_fs();
 	set_fs(KERNEL_DS);
@@ -283,8 +314,12 @@
 		if (put_user(err, &srcptr->result))
 			err = -EFAULT;
 	}
+__xfern_out:
+  for (i = 0; i < cp; i++) {
+    kfree(bufs[i]);
+  }
 	kfree(bufs);
-	return 0;
+	return err;
 }
 
 
@@ -402,7 +437,7 @@
 		struct sndrv_pcm_mmap_control32 control;
 		unsigned char reserved[64];
 	} c;
-} __attribute__((packed));
+};  //__attribute__((packed));
 
 #define CVT_sndrv_pcm_sync_ptr()\
 {\
@@ -456,7 +491,7 @@
 	SNDRV_PCM_IOCTL_READN_FRAMES32 = _IOR('A', 0x53, struct sndrv_xfern32),
 	SNDRV_PCM_IOCTL_HW_REFINE_OLD32 = _IOWR('A', 0x10, struct sndrv_pcm_hw_params_old32),
 	SNDRV_PCM_IOCTL_HW_PARAMS_OLD32 = _IOWR('A', 0x11, struct sndrv_pcm_hw_params_old32),
-	SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct sndrv_pcm_sync_ptr),
+	SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct sndrv_pcm_sync_ptr32),
 
 };
 

--ikeVEW9yuYc//A+q--
