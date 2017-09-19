From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 18:44:24 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <7b046745-3658-05a1-981a-77708fdde7cd@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/19/2017 08:14 PM, David Miller wrote:
>> Does it work without root privileges?
> 
> Depends upon what permissions and ownership the administrator decides
> to set for /dev/mdesc
> 
> Which is identical to what you would get with sysfs, "file permissions"
> 
> This conversation is going nowhere, can you guys please drop this?

It's not going anywhere because you are not open to discussion. You
are stuck in your opinion coming from your own personal usecase and
refuse to accept that other users have different usecases.

> We're not exporting the machine desctription in a second way, period.

Not "we", you. You are refusing to make progress and that's frustrating,
especially for all the folk from Oracle who are sending in patches all
the time.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
