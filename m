From: Mathieu Chouquet-Stringer <mchouque@online.fr>
Date: Wed, 12 May 2004 19:45:11 +0000
Subject: Re: Another gcc 3.4 fix
Message-Id: <20040512194511.GA15250@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <20040512052744.GA31207@localhost>
In-Reply-To: <20040512052744.GA31207@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, May 12, 2004 at 12:15:18PM -0700, David S. Miller wrote:
> It can't be the same in both cases, because something is
> making kernel_unaligned_trap_fault underfined right?  

My bad, I had the -fno-unit-at-a-time option on the command line.

So with the original version of unaligned.c, there's a
kernel_unaligned_trap in the .s file but no kernel_unaligned_trap_fault
(only references to it) and no unaligned_panic. (am I making myself clear
here?)

That's why I was saying I don't get it: why forcing gcc to generate code
for unaligned_panic make it build kernel_unaligned_trap_fault?

> One way is for it not to get emitted at all, and that's what
> I thought was occurring with gcc-3.4 builds.
>
> Meanwhile, I've put your workaround in for the time being.

Ok.
-- 
Mathieu Chouquet-Stringer                 E-Mail: mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
