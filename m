From: "C.Newport" <crn@netunix.com>
Date: Wed, 18 Aug 2004 21:57:47 +0000
Subject: Re: Sun4d progress
Message-Id: <200408182257.47817.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 18 August 2004 10:33 pm, William Lee Irwin III wrote:
> On Wed, Aug 18, 2004 at 10:28:01PM +0100, Chris Newport wrote:
> > I have cleaned up Thomas Bogendoerfer's patches from the list archives
> > which seem to be infested with html. ( clean version pasted in below ).
> > Building 2.4.22 and 2.4.27 with both gcc-egcs-2.91.66 and gcc 3.2.2
> > I get a bootable UP system but SMP locks up after
> > ioremap: done with statics, switching to malloc.
> > Does anyone know what is happening ?
>
> I won't know for a while, no. I'll work on explaining what each of
> these the changes in the patch are and breaking them up into logically
> separate patches for submission to Marcelo, and run them past you and
> Thomas Bogendoerfer beforehand.

Thanks, please could you proof-read the patches very carefully against 
the archive of Thomas's patches at 
http://marc.theaimsgroup.com/?l=linux-sparc&m6467967231116&w=2

I ended up transcribing these by hand, I have checked carefully for tyops
but I am not infallible and extra pairs of eyes may spot something I have 
missed.

Something odd is going on - Thomas claimed that 2.4.23-pre5 booted but
was unstable, which I cannot achieve. Maybe our environments are 
different, but I have built this 4 times with 2.4.22 and 2.4.27 on both
old and new compilers and the result is consistent. Maybe Thomas had
applied some other patch before these ?.

Chris.


