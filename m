From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 17:38:38 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <35b2d1dd-9cf5-cee6-4428-86d4765fd338@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/19/2017 07:32 PM, David Miller wrote:
>> Is there anything that prevents us from removing it?
> 
> Yes, I and others have tools like mdlint that we use every day?!?!

This one? [1]

Otherwise I don't know of any "mdlint" tool. I just know that using
sysfs is the standard way of reading information from the kernel these
days, on all architectures.

Adrian

> [1] https://github.com/ChrisWren/mdlint

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
