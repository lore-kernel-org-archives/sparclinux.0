From: "David S. Miller" <davem@redhat.com>
Date: Thu, 01 Jul 2004 05:25:47 +0000
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-Id: <20040630222547.65d793da.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040630030503.GA25149@mail.shareable.org>
	<20040630082804.GS21264@devserv.devel.redhat.com>
	<20040630135419.25b843b8.davem@redhat.com>
	<20040630225220.GA32560@mail.shareable.org>
In-Reply-To: <20040630225220.GA32560@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jamie Lokier <jamie@shareable.org>
Cc: jakub@redhat.com, wesolows@foobazco.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 23:52:20 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> The PaX security patch already implements R!X pages on Sparc64, so you
> could just cut out that part of the patch.  Just pick out the changes
> to arch/sparc64/* and include/asm-sparc64/*:
> 
> 	http://pax.grsecurity.net/pax-linux-2.6.7-200406252135.patch
> 
> It appears to use exactly the technique Jakub describes, and has been tested.

Great, I'm integrating something along these lines right now.

Do you have any idea who authored the sparc64 bits so I can give
them credit?
