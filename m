From: "David S. Miller" <davem@redhat.com>
Date: Mon, 02 Feb 2004 18:18:24 +0000
Subject: Re: [sparc32] Align pkmap properly
Message-Id: <20040202101824.423fb782.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040202093439.GA22498@foobazco.org>
In-Reply-To: <20040202093439.GA22498@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2 Feb 2004 01:34:39 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> Dave, please apply.
 ...
> # Align the pkmap area on a 4MB region so that a single
> # large pagetable can be used.  Fixes random killing of
> # processes which used high memory.

Applied, thanks Keith.
