From: "David S. Miller" <davem@redhat.com>
Date: Wed, 21 Jul 2004 20:51:03 +0000
Subject: Re: [PATCH 2.6] define pci_dma_mapping_error for sparc
Message-Id: <20040721135103.6d8fb587.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1089671439.20813.31.camel@localhost.localdomain>
In-Reply-To: <1089671439.20813.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 12 Jul 2004 17:33:23 -0500
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> On Mon, 2004-07-12 at 17:30 -0500, Tom 'spot' Callaway wrote:
> > Sparc32 is missing the pci_dma_mapping_error function in pci.h, this
> > patch adds it.
> 
> Ugh. Use this revision instead, sorry for the nasty whitespace.

Applied, thanks Tom.
