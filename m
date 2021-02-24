From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 24 Feb 2021 12:04:04 +0000
Subject: Re: Newer kernels fail to boot on a U450?
Message-Id: <9e66c20d-ad1c-3fd3-221a-bb17e9623b64@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
In-Reply-To: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Mark!

On 2/24/21 12:14 PM, Mark Cave-Ayland wrote:
> Do people still run newer kernels on older hardware? If there is interest,
> I may be able to get some more diagnostic information. In particular I'd be
> curious to know if Oracle do any routine testing of newer kernels on machines
> such as the U450 and whether anyone there can reproduce the problem.

I think this must be an issue specific to this machine or this model as I haven't
seen such issues myself when testing on older machines.

There is a stability issue on newer kernels on older hardware that is currently
being debugged though [1].

Adrian

> [1] https://marc.info/?l=linux-sparc&m1399891728083&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
