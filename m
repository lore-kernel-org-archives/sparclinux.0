From: David Miller <davem@davemloft.net>
Date: Thu, 25 Dec 2014 23:39:30 +0000
Subject: Re: [PATCH repost 15/16] sparc/uaccess: fix sparse errors
Message-Id: <20141225.183930.2234745020223954872.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1419499661-8566-1-git-send-email-mst@redhat.com>
	<1419499661-8566-16-git-send-email-mst@redhat.com>
In-Reply-To: <1419499661-8566-16-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, sam@ravnborg.org, dave.kleikamp@oracle.com, sparclinux@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 25 Dec 2014 11:30:22 +0200

> virtio wants to read bitwise types from userspace using get_user.  At the
> moment this triggers sparse errors, since the value is passed through an
> integer.
> 
> Fix that up using __force.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Patches #14 and #15 have identical commit message header lines, you
need to say "sparc32: " or "sparc64: " so that shortlog scanners can
distinguish them.

Thanks.
