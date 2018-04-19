From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 19 Apr 2018 17:21:53 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <c3217979-ca04-0509-698c-60a6c707ee14@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/19/2018 05:41 PM, David Miller wrote:
> Then it could be pre-Ultra-IIIi systems that trigger the problem.
> Ultra30 is as such.

Possible. But I haven't received any such bug report from Debian users
yet and we have people running the sparc64 port on machines as old
as the Ultra 10.

Rene, would you mind testing Debian's sparc64 port on your machine?

Just booting the installation image is probably enough provided the
bug shows immediately once the kernel is booted. See [1].

Adrian

> [1] https://cdimage.debian.org/cdimage/ports/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
