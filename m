From: Tom Hromatka <tom.hromatka@oracle.com>
Date: Tue, 24 Apr 2018 16:47:53 +0000
Subject: Re: [PATCH v5 1/2] char: sparc64: Add privileged ADI driver
Message-Id: <3648cb70-c5a0-c316-4e61-93c533ea0bcc@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180423173332.561489-1-tom.hromatka@oracle.com>
 <20180423173332.561489-2-tom.hromatka@oracle.com>
 <20180423175216.GA16904@kroah.com>
In-Reply-To: <20180423175216.GA16904@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org



On 04/23/2018 11:52 AM, Greg KH wrote:
> On Mon, Apr 23, 2018 at 11:33:31AM -0600, Tom Hromatka wrote:
>> SPARC M7 and newer processors utilize ADI to version and
>> protect memory.  This driver is capable of reading/writing
>> ADI/MCD versions from privileged user space processes.
>> Addresses in the adi file are mapped linearly to physical
>> memory at a ratio of 1:adi_blksz.  Thus, a read (or write)
>> of offset K in the file operates upon the ADI version at
>> physical address K * adi_blksz.  The version information
>> is encoded as one version per byte.  Intended consumers
>> are makedumpfile and crash.
> What do you mean by "crash"?  Should this tie into the pstore
> infrastructure, or is this just a userspace thing?  Just curious.

My apologies.  I was referring to the crash utility:
https://github.com/crash-utility/crash

A future commit to store the ADI versions to the pstore would be
really cool.  I am fearful the amount of ADI data could overwhelm
the pstore, though.  The latest sparc machines support 4 TB of RAM
which could mean several GBs of ADI versions.  But storing the ADI
versions pertaining to the failing code should be possible.  I need
to do more research...

>
> Minor code comments below now that the license stuff is correct, I
> decided to read the code :)

:)

>> +#include <linux/kernel.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/module.h>
>> +#include <linux/proc_fs.h>
>> +#include <linux/slab.h>
>> +#include <linux/uaccess.h>
>> +#include <asm/asi.h>
>> +
>> +#define MODULE_NAME	"adi"
> What's wrong with KBUILD_MODNAME?  Just use that instead of MODULE_NAME
> later on in the file.

Good catch.  I'll do that in the next rev of this patch.

>> +#define MAX_BUF_SZ	4096
> PAGE_SIZE?  Just curious.

When a user requests a large read/write in makedumpfile or the crash
utility, these tools typically make requests in 4096-sized chunks.
I believe you are correct that these operations are based upon page
size, but I have not verified.  I was hesitant to connect MAX_BUF_SZ to
PAGE_SIZE without this verification.  I'll look into it more...

>> +
>> +static int adi_open(struct inode *inode, struct file *file)
>> +{
>> +	file->f_mode |= FMODE_UNSIGNED_OFFSET;
> That's odd, why?

sparc64 currently supports 4 TB of RAM (and could support much more in the
future).  Offsets into this ADI privileged driver are address / 64, but
that could change also in the future depending upon cache line sizes.  I
was afraid that future sparc systems could have very large file offsets.
Overkill?

>
>> +	return 0;
>> +}
>> +
>> +static int read_mcd_tag(unsigned long addr)
>> +{
>> +	long err;
>> +	int ver;
>> +
>> +	__asm__ __volatile__(
>> +		"1:	ldxa [%[addr]] %[asi], %[ver]\n"
>> +		"	mov 0, %[err]\n"
>> +		"2:\n"
>> +		"	.section .fixup,#alloc,#execinstr\n"
>> +		"	.align 4\n"
>> +		"3:	sethi %%hi(2b), %%g1\n"
>> +		"	jmpl  %%g1 + %%lo(2b), %%g0\n"
>> +		"	mov %[invalid], %[err]\n"
>> +		"	.previous\n"
>> +		"	.section __ex_table, \"a\"\n"
>> +		"	.align 4\n"
>> +		"	.word  1b, 3b\n"
>> +		"	.previous\n"
>> +		: [ver] "=r" (ver), [err] "=r" (err)
>> +		: [addr] "r"  (addr), [invalid] "i" (EFAULT),
>> +		  [asi] "i" (ASI_MCD_REAL)
>> +		: "memory", "g1"
>> +		);
>> +
>> +	if (err)
>> +		return -EFAULT;
>> +	else
>> +		return ver;
>> +}
>> +
>> +static ssize_t adi_read(struct file *file, char __user *buf,
>> +			size_t count, loff_t *offp)
>> +{
>> +	size_t ver_buf_sz, bytes_read = 0;
>> +	int ver_buf_idx = 0;
>> +	loff_t offset;
>> +	u8 *ver_buf;
>> +	ssize_t ret;
>> +
>> +	ver_buf_sz = min_t(size_t, count, MAX_BUF_SZ);
>> +	ver_buf = kmalloc(ver_buf_sz, GFP_KERNEL);
>> +	if (!ver_buf)
>> +		return -ENOMEM;
>> +
>> +	offset = (*offp) * adi_blksize();
>> +
>> +	while (bytes_read < count) {
>> +		ret = read_mcd_tag(offset);
>> +		if (ret < 0)
>> +			goto out;
>> +
>> +		ver_buf[ver_buf_idx] = (u8)ret;
> Are you sure ret fits in 8 bits here?

Yes, I believe so.  read_mcd_tag() will return a negative number
on an error - which is checked a couple lines above.  Otherwise,
the read succeeded which means a valid ADI version was returned.
Valid ADI versions are 0 through 16.

>> +		ver_buf_idx++;
>> +		offset += adi_blksize();
>> +
>> +		if (ver_buf_idx >= ver_buf_sz) {
>> +			if (copy_to_user(buf + bytes_read, ver_buf,
>> +					 ver_buf_sz)) {
>> +				ret = -EFAULT;
>> +				goto out;
>> +			}
>> +
>> +			bytes_read += ver_buf_sz;
>> +			ver_buf_idx = 0;
>> +
>> +			ver_buf_sz = min(count - bytes_read,
>> +					 (size_t)MAX_BUF_SZ);
>> +		}
>> +	}
>> +
>> +	(*offp) += bytes_read;
>> +	ret = bytes_read;
>> +out:
>> +	kfree(ver_buf);
>> +	return ret;
>> +}
>> +
>> +static int set_mcd_tag(unsigned long addr, u8 ver)
>> +{
>> +	long err;
>> +
>> +	__asm__ __volatile__(
>> +		"1:	stxa %[ver], [%[addr]] %[asi]\n"
>> +		"	mov 0, %[err]\n"
>> +		"2:\n"
>> +		"	.section .fixup,#alloc,#execinstr\n"
>> +		"	.align 4\n"
>> +		"3:	sethi %%hi(2b), %%g1\n"
>> +		"	jmpl %%g1 + %%lo(2b), %%g0\n"
>> +		"	mov %[invalid], %[err]\n"
>> +		"	.previous\n"
>> +		"	.section __ex_table, \"a\"\n"
>> +		"	.align 4\n"
>> +		"	.word 1b, 3b\n"
>> +		"	.previous\n"
>> +		: [err] "=r" (err)
>> +		: [ver] "r" (ver), [addr] "r"  (addr),
>> +		  [invalid] "i" (EFAULT), [asi] "i" (ASI_MCD_REAL)
>> +		: "memory", "g1"
>> +		);
>> +
>> +	if (err)
>> +		return -EFAULT;
>> +	else
>> +		return ver;
>> +}
>> +
>> +static ssize_t adi_write(struct file *file, const char __user *buf,
>> +			 size_t count, loff_t *offp)
>> +{
>> +	size_t ver_buf_sz, bytes_written = 0;
>> +	loff_t offset;
>> +	u8 *ver_buf;
>> +	ssize_t ret;
>> +	int i;
>> +
>> +	if (count <= 0)
>> +		return -EINVAL;
>> +
>> +	ver_buf_sz = min_t(size_t, count, MAX_BUF_SZ);
>> +	ver_buf = kmalloc(ver_buf_sz, (size_t)GFP_KERNEL);
> (size_t) for GFP_KERNEL?  That's really odd looking.

Agreed.  Good find.

>
>> +	if (!ver_buf)
>> +		return -ENOMEM;
>> +
>> +	offset = (*offp) * adi_blksize();
>> +
>> +	do {
>> +		if (copy_from_user(ver_buf, &buf[bytes_written],
>> +				   ver_buf_sz)) {
>> +			ret = -EFAULT;
>> +			goto out;
>> +		}
>> +
>> +		for (i = 0; i < ver_buf_sz; i++) {
>> +			ret = set_mcd_tag(offset, ver_buf[i]);
>> +			if (ret < 0)
>> +				goto out;
>> +
>> +			offset += adi_blksize();
>> +		}
>> +
>> +		bytes_written += ver_buf_sz;
>> +		ver_buf_sz = min(count - bytes_written, (size_t)MAX_BUF_SZ);
>> +	} while (bytes_written < count);
>> +
>> +	(*offp) += bytes_written;
>> +	ret = bytes_written;
>> +out:
>> +	__asm__ __volatile__("membar #Sync");
>> +	kfree(ver_buf);
>> +	return ret;
>> +}
>> +
>> +static loff_t adi_llseek(struct file *file, loff_t offset, int whence)
>> +{
>> +	loff_t ret = -EINVAL;
>> +
>> +	switch (whence) {
>> +	case SEEK_END:
>> +	case SEEK_DATA:
>> +	case SEEK_HOLE:
>> +		/* unsupported */
>> +		return -EINVAL;
>> +	case SEEK_CUR:
>> +		if (offset = 0)
>> +			return file->f_pos;
>> +
>> +		offset += file->f_pos;
>> +		break;
>> +	case SEEK_SET:
>> +		break;
>> +	}
>> +
>> +	if (offset != file->f_pos) {
>> +		file->f_pos = offset;
>> +		file->f_version = 0;
>> +		ret = offset;
>> +	}
>> +
>> +	return ret;
>> +}
> Why can't you use default_llseek here?  Why do you not allow HOLE and
> others?

I believe default_llseek() would work, but I chose not to use it because I
haven't tested some cases - like SEEK_HOLE.  My ADI changes to makedumpfile
and crash utility don't utilize SEEK_HOLE.  I felt uncomfortable providing
a feature without testing it thoroughly, so I decided to save it for a
future patchset.

>
> Anyway, just tiny questions, all are trivial and not really a big deal
> if you have tested it on your hardware.  I'm guessing this will go
> through the SPARC tree?  If so feel free to add:

That was my plan since this driver is only applicable to sparc64 machines.
But I'm open to however you and Dave M think it would be best to proceed.

>
> 	Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Or if you want/need me to take it through my char/misc tree, just let me
> know and I can.

Thanks so much for the help.  I really appreciate it.

Tom

>
> thanks,
>
> greg k-h

