From: Christoph Hellwig <hch@infradead.org>
Date: Thu, 06 Nov 2008 17:32:24 +0000
Subject: Re: sparc/staging compile error
Message-Id: <20081106173224.GA25767@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081106163626.2306ad75.sfr@canb.auug.org.au> <20081106063709.GB7728@kroah.com> <18706.51153.342079.586525@cargo.ozlabs.ibm.com> <3aaafc130811060606p1dfbf12cr8c0dc8cd310d0279@mail.gmail.com>
In-Reply-To: <3aaafc130811060606p1dfbf12cr8c0dc8cd310d0279@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J.R. Mauro" <jrm8005@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>, LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "William L. Irwin" <wli@holomorphy.com>, sparclinux@vger.kernel.org

On Thu, Nov 06, 2008 at 09:06:36AM -0500, J.R. Mauro wrote:
> static int poch_ioctl(struct inode *inode, struct file *filp,
>                       unsigned int cmd, unsigned long arg)
> {
> /* ---snip---*/
>         case POCH_IOC_SYNC_GROUP_FOR_USER:
>         case POCH_IOC_SYNC_GROUP_FOR_DEVICE:
>                 vms = find_vma(current->mm, arg);
>                 if (!vms)
>                         /* Address not mapped. */
>                         return -EINVAL;
>                 if (vms->vm_file != filp)
>                         /* Address mapped from different device/file. */
>                         return -EINVAL;
> 
>                 flush_cache_range(vms, arg, arg + channel->group_size);

This doesn't look like something a driver should ever do.  Could someone
explain what it's trying to do from a high level point of view?

