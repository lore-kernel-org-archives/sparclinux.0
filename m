From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 18 Aug 2004 21:33:28 +0000
Subject: Re: Sun4d progress
Message-Id: <20040818213328.GJ11200@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 18, 2004 at 10:28:01PM +0100, Chris Newport wrote:
> I have cleaned up Thomas Bogendoerfer's patches from the list archives
> which seem to be infested with html. ( clean version pasted in below ).
> Building 2.4.22 and 2.4.27 with both gcc-egcs-2.91.66 and gcc 3.2.2
> I get a bootable UP system but SMP locks up after
> ioremap: done with statics, switching to malloc.
> Does anyone know what is happening ?

I won't know for a while, no. I'll work on explaining what each of
these the changes in the patch are and breaking them up into logically
separate patches for submission to Marcelo, and run them past you and
Thomas Bogendoerfer beforehand.


-- wli
