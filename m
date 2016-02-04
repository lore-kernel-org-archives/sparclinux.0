From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 04 Feb 2016 17:49:22 +0000
Subject: Re: [PATCH v7 9/9] vring: Use the DMA API on Xen
Message-Id: <CALCETrXs_2dhuBMo=oMDHF7W+QpVW5haj+audrZZo+f6sZJyNA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1454477782.git.luto@kernel.org>
	<a5b072806984a0fceb4f4d33cbeb1cea7d881e8b.1454477782.git.luto@kernel.org>
	<56B1CD18.1050509@citrix.com>
In-Reply-To: <56B1CD18.1050509@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Vrabel <david.vrabel@citrix.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Wed, Feb 3, 2016 at 1:49 AM, David Vrabel <david.vrabel@citrix.com> wrote:
> On 03/02/16 05:46, Andy Lutomirski wrote:
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> You forgot the previous Reviewed-by tags.

Whoops.  If I send another version, they'll be there.

>
> David



-- 
Andy Lutomirski
AMA Capital Management, LLC
