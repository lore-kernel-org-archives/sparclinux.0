From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 20:24:00 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.132400.717038318205069322.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 20:44:20 +0200

> On 09/19/2017 08:40 PM, David Miller wrote:
>>> And you really shouldn't take your usecase and experience as the
>>> reference. You're a very experienced and long time user and know all
>>> the quirks and details of the platform. Of course, you don't need
>>> something that is user-friendly. But the majority of Linux users do.
>> 
>> I guess typing "prtconf -pv" is not very user friendly.
> 
> "prtconf" is not part of any Linux distribution I know of.

davem@patience:~/src/GIT/sparc-next$ dpkg -S /usr/sbin/prtconf 
sparc-utils: /usr/sbin/prtconf

Come again?
