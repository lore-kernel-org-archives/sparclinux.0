From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 06 Dec 2004 05:23:53 +0000
Subject: Re: mmap breakage
Message-Id: <20041205212353.7156b495.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 5 Dec 2004 23:30:53 -0500 (EST)
Jurij Smakov <jurij@wooyd.org> wrote:

> So now the question is why ld-linux.so.2 on sparc64 is mapped at 
> 0x08000000 instead of something higher, like 0x80000000 on i386? This
> actually limits the size of an executable plus all the shared libraries 
> required by it (if I understand it correctly) to 128MB. Can this limit be 
> easily modified, or are there some special architectural considerations, 
> preventing that?

It only limits the shared libraries as you state for the "medlow"
code model which restricts the binary to the low 32-bits of the
address space.

For the other 64-bit code models, we have large chunks of the rest
of the 64-bit address space in which to map things.

In fact, actually, PIC code such as shared libraries should be
mapped in the upper parts of the 64-bit address space.  The kernel
should start trying to map things for the user at 0xFFFFF80000000000
unless the user specifies a specific address.

Also the stack starts way up high in the 64-bit address space as well,
and this is for all code models.

We could put ld-linux.so.2 somewhere else, that's not too hard.  I
would suggest putting it at that 0xfffff80000000000 address I quoted
above since that is where the rest of the shared objects are going
to end up anyways.

A good person to ask about the logistics of moving ld-linux.so.2 somewhere
else would be Jakub Jelinek <jakub@redhat.com>
