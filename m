From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2015 18:21:52 +0000
Subject: Re: [PATCH v2 15/40] sparc64/uaccess: fix sparse errors
Message-Id: <20150106.132152.994204445203435419.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
	<1420558883-10131-16-git-send-email-mst@redhat.com>
In-Reply-To: <1420558883-10131-16-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, sam@ravnborg.org, sparclinux@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 6 Jan 2015 17:44:20 +0200

> virtio wants to read bitwise types from userspace using get_user.  At the
> moment this triggers sparse errors, since the value is passed through an
> integer.
> 
> Fix that up using __force.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
