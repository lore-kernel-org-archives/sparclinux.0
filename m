From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 22 May 2012 06:40:19 +0000
Subject: Re: How to recognize a LEON CPU?
Message-Id: <4FBB34D3.8030403@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120521162253.GB5733@merkur.ravnborg.org>
In-Reply-To: <20120521162253.GB5733@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 05/21/2012 06:22 PM, Sam Ravnborg wrote:
> Who is the relevant Gaisler contact person these days for Linux stuff?
> I sometimes uses Daniel, sometimes Konrad.
Please CC both of us. Kristoffer Glembo is no longer active though.

> I can just add both of you - this is no problem.
> As I plan to update the LEON integration it would be good
> to have in place.
>
> Anyway - the real question..
>
> In head_32.S I need very early on to determine the CPU type,
> so I can distingush between LEON and SUN.
> This is due to LEON using a different ASI for mmuregs
> as discussed in another mail.
>
> I assume this can be determinded from PSR.
> If this is correct - then what values shall I use
> to determine if the relevant cpu is LEON or SUN?
The LEON is SPARC compliant and has a registered number, from the manual (http://gaisler.com/products/grlib/grip.pdf section LEON3 and LEON4):

65.2.3 SPARC Implementor's ID
Gaisler Research is assigned number 15 (0xF) as SPARC implementor's identification. This value is
hard-coded into bits 31:28 in the %psr register. The version number for LEON3 is 3, which is hard-
coded in to bits 27:24 of the %psr.


Note that LEON3 and LEON4 have the same version number, they are software compatible.

Daniel
