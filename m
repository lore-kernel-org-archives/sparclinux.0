From: Andrew Morton <akpm@osdl.org>
Date: Fri, 25 Jun 2004 18:53:48 +0000
Subject: Re: [SPARC64] kernel 2.6.7+cset-20040625_0611 = ERROR
Message-Id: <20040625115348.371dcb0b.akpm@osdl.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58L.0406251320310.6037@alpha.zarz.agh.edu.pl>
	<20040625030502.40e25d42.akpm@osdl.org>
	<20040625103020.25b37791.davem@redhat.com>
In-Reply-To: <20040625103020.25b37791.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: cieciwa@alpha.zarz.agh.edu.pl, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> On Fri, 25 Jun 2004 03:05:02 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl> wrote:
> > >
> > > make[1]: *** [arch/sparc64/kernel/process.o] Error 1
> > >  make: *** [arch/sparc64/kernel] Error 2
> > 
> > here's t'other:
> 
> Ok, is it only gcc-3.4 and later that spit out these warnings?
> I've been doing gcc-3.3 builds without incident... oh or maybe
> only on SMP.  I haven't tried a uniprocessor build in a while.

I'm using gcc-3.3.2, CONFIG_SMP=y and was able to reproduce the warnings.
