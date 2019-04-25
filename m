From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 25 Apr 2019 15:32:05 +0000
Subject: Re: [PATCH v3 12/26] compat_ioctl: move more drivers to compat_ptr_ioctl
Message-Id: <CAK8P3a1qCQJEkne3uAw-Ep-taNU9t5Y2ZmgoiCGmOz1BSwmzEw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202701.127745-1-arnd@arndb.de>
 <20190425122153.450fc094@coco.lan>
In-Reply-To: <20190425122153.450fc094@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: linux-nvme@lists.infradead.org, Sean Young <sean@mess.org>, linux-iio@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-pci <linux-pci@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, sparclinux <sparclinux@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-nvdimm@lists.01.org, linux-rdma <linux-rdma@vger.kernel.org>, qat-linux@intel.com, amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@mellanox.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-remoteproc@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Sterba <dsterba@suse.com>, ceph

On Thu, Apr 25, 2019 at 5:22 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> Em Tue, 16 Apr 2019 22:25:33 +0200 Arnd Bergmann <arnd@arndb.de> escreveu:
>
> If I understand your patch description well, using compat_ptr_ioctl
> only works if the driver is not for s390, right?

No, the purpose of compat_ptr_ioctl() is to make sure it works
everywhere including s390.

Even on s390 it tends to work most of the time, but for correctness
the upper bit of a 32-bit pointer needs to be cleared, as
compat_ptr_ioctl does, in case some application passes a pointer
with that bit set. [IIRC, in the instruction pointer, the high bit is set, in
data references it is ignored but usually cleared, but it may be left
on for IP-relative address generation]

       Arnd
