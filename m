From: "Jean-Fabrice [gmail]" <jeanfabrice@gmail.com>
Date: Thu, 26 Oct 2006 13:38:52 +0000
Subject: Re: qla2xxx issue on >2.6.17 kernel
Message-Id: <da053ca90610260638m8f3b476y7c8e6aa89ff20650@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <da053ca90610170139l693952d4xf09ab500a5e66b12@mail.gmail.com>
In-Reply-To: <da053ca90610170139l693952d4xf09ab500a5e66b12@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

2006/10/24, David Miller <davem@davemloft.net>:
> Unfortunately the current driver requires that the firmware
> be available on the filesystem, loaded via the kernel firmware
> interface, when the driver kernel module loads.
>
> This makes using the driver in a static kernel without an attached
> root ramfs containing the firmware basically impossible.
>
> The drivers/scsi/qla2xxx/Kconfig help text explains where to
> obtain the firmware from.
>
Thank you for this clear explanation. I'll give another try with an
initramfs and see if it helps.

JF
