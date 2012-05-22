From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 22 May 2012 06:41:02 +0000
Subject: Re: How to recognize a LEON CPU?
Message-Id: <4FBB34FE.4030304@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120521162253.GB5733@merkur.ravnborg.org>
In-Reply-To: <20120521162253.GB5733@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 05/21/2012 11:12 PM, David Miller wrote:
> From: Sam Ravnborg<sam@ravnborg.org>
> Date: Mon, 21 May 2012 18:22:53 +0200
>
>> I assume this can be determinded from PSR.
> > From arch/sparc/kernel/cpu.c:
>
> psr IMPL 0xf with psr VERS of 3
Correct. As I written Sam:

The LEON is SPARC compliant and has a registered number, from the manual (http://gaisler.com/products/grlib/grip.pdf section LEON3 and LEON4):

65.2.3 SPARC Implementor's ID
Gaisler Research is assigned number 15 (0xF) as SPARC implementor's identification. This value is
hard-coded into bits 31:28 in the %psr register. The version number for LEON3 is 3, which is hard-
coded in to bits 27:24 of the %psr.


Note that LEON3 and LEON4 have the same version number, they are software compatible.

Daniel
