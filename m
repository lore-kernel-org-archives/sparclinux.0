From: David Miller <davem@davemloft.net>
Date: Tue, 24 Oct 2006 08:29:14 +0000
Subject: Re: qla2xxx issue on >2.6.17 kernel
Message-Id: <20061024.012914.35016791.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <da053ca90610170139l693952d4xf09ab500a5e66b12@mail.gmail.com>
In-Reply-To: <da053ca90610170139l693952d4xf09ab500a5e66b12@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Jean-Fabrice [gmail]" <jeanfabrice@gmail.com>
Date: Tue, 24 Oct 2006 09:28:45 +0200

> I wondered if my mail reach the mailing list. Did I miss something in
> the way I post ?

Unfortunately the current driver requires that the firmware
be available on the filesystem, loaded via the kernel firmware
interface, when the driver kernel module loads.

This makes using the driver in a static kernel without an attached
root ramfs containing the firmware basically impossible.

The drivers/scsi/qla2xxx/Kconfig help text explains where to
obtain the firmware from.
