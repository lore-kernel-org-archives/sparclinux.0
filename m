From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 04 Jun 2017 20:38:44 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <f731dcd9-c1f3-52ca-46a5-f4ed1cca6e61@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <d58c5980-c973-a74f-292c-f246680ec246@physik.fu-berlin.de>
 <20170604.163042.2037487368752934309.davem@davemloft.net>
 <374faa2d-3a77-3a8e-e214-9d635a1f2ec0@physik.fu-berlin.de>
 <20170604.163422.1495211552291226243.davem@davemloft.net>
In-Reply-To: <20170604.163422.1495211552291226243.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>

On 06/04/2017 10:34 PM, David Miller wrote:
> Please post your sparc64 system specs.

It's a SPARC-T5 running Debian inside an LDOM with 94 GiB RAM
and 128 active CPU threads.

I don't know the exact specs as the machine is owned by Anatoly
Pugachev. I'm CC'ing him so he can disclose the remaining specs.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
