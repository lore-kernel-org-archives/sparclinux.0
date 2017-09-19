From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 17:40:30 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <6ddf8480-40cc-fd4d-4fe6-74d72c2b0edc@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/19/2017 07:31 PM, David Miller wrote:
> All of that complexity and knowledge of formatting properties this way
> or that has no business in the kernel, and belongs completely in
> userspace.

But that's not really contradicting to the fact that this information
belongs to sysfs, not some obscure device node below /dev.

Basically every human-readable information from the kernel is provided
through sysfs these days. Why should it be different for SPARC?

I really don't think that makes any sense.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
