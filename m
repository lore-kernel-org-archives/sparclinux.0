From: "David S. Miller" <davem@redhat.com>
Date: Thu, 25 Mar 2004 20:06:12 +0000
Subject: Re: Compile problem on sparc64
Message-Id: <20040325120612.5f8ab917.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040324121914.00fb9bf9.davem@redhat.com>
In-Reply-To: <20040324121914.00fb9bf9.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 24 Mar 2004 23:56:25 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> here it is.

Marcel, I think you're using gcc-3.5, because gcc-3.3.x does not
even warn for these things at all, else I'd be seeing this for
ages.

Can you double check what "gcc --version" gives?

Thanks.
