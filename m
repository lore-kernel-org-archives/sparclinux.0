From: David Miller <davem@davemloft.net>
Date: Tue, 17 Apr 2007 21:13:52 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070417.141352.97294412.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 17 Apr 2007 15:52:37 -0500

> Err, to reply to my own email:
> 
> It only mounts correctly with -t iso9660. If I try to mount without
> specifying type, it throws those Buffer I/O errors and asks me to
> manually specify filesystem type:

That explains things.  If you don't give it a filesystem type it will
probably try to scan around looking for superblock magic signatures
and stuff like that, which likely doesn't work very well for ISO9660
filesystems on CDROMs it appears.
