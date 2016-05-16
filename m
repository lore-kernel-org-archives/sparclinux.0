From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 16 May 2016 15:14:39 +0000
Subject: Re: Definition of __sparc64__ in gcc
Message-Id: <5739E3DF.10601@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <5739BBAC.2030804@physik.fu-berlin.de>
In-Reply-To: <5739BBAC.2030804@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 05/16/2016 05:08 PM, David Miller wrote:
>> Any comments?
> 
> The correct test has always been "__sparc__ && __arch64__"

Good, then I'll have some packages to fix :).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
