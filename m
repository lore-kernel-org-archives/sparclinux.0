From: Vijay Kumar <vijaykumar@bravegnu.org>
Date: Fri, 07 Nov 2008 08:52:01 +0000
Subject: Re: sparc/staging compile error
Message-Id: <4913FEE1.9030807@bravegnu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081106163626.2306ad75.sfr@canb.auug.org.au>	 <20081106063709.GB7728@kroah.com>	 <18706.51153.342079.586525@cargo.ozlabs.ibm.com>	 <3aaafc130811060606p1dfbf12cr8c0dc8cd310d0279@mail.gmail.com>	 <20081106173224.GA25767@infradead.org> <3aaafc130811060936u371e8b9eyccd0c52693f4c433@mail.gmail.com>
In-Reply-To: <3aaafc130811060936u371e8b9eyccd0c52693f4c433@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J.R. Mauro" <jrm8005@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>, LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "William L. Irwin" <wli@holomorphy.com>, jayakumar.lkml@gmail.com, sparclinux@vger.kernel.org

J.R. Mauro wrote:
> On Thu, Nov 6, 2008 at 12:32 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Thu, Nov 06, 2008 at 09:06:36AM -0500, J.R. Mauro wrote:
>>> static int poch_ioctl(struct inode *inode, struct file *filp,
>>>                       unsigned int cmd, unsigned long arg)
>>> {
>>> /* ---snip---*/
>>>         case POCH_IOC_SYNC_GROUP_FOR_USER:
>>>         case POCH_IOC_SYNC_GROUP_FOR_DEVICE:
>>>                 vms = find_vma(current->mm, arg);
>>>                 if (!vms)
>>>                         /* Address not mapped. */
>>>                         return -EINVAL;
>>>                 if (vms->vm_file != filp)
>>>                         /* Address mapped from different device/file. */
>>>                         return -EINVAL;
>>>
>>>                 flush_cache_range(vms, arg, arg + channel->group_size);
>> This doesn't look like something a driver should ever do.  Could someone
>> explain what it's trying to do from a high level point of view?
>
> CC'd driver maintainers mentioned in the README

May be the code is not doing what is supposed to do, but here is what the 
driver is trying to achieve:

The driver allocates a set of buffers for DMA. These buffers are mapped 
into user space, when the user does an mmap. In transmit, when the user 
space writes to these buffers, the data has to reach physical memory so 
that the device can access them. For receive, the cache has to be 
invalidated before the user space reads the buffer.

Do let me know if further clarification is required. Any inputs and 
suggestions are welcome.

BTW, please do send in the compiler error message.

Regards,
Vijay
