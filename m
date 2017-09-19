From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 18:07:50 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.110750.1287027619002808466.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 19:38:38 +0200

> On 09/19/2017 07:32 PM, David Miller wrote:
>>> Is there anything that prevents us from removing it?
>> 
>> Yes, I and others have tools like mdlint that we use every day?!?!
> 
> This one? [1]
> 
> Otherwise I don't know of any "mdlint" tool. I just know that using
> sysfs is the standard way of reading information from the kernel these
> days, on all architectures.

I took the mdlint tool Solaris uses and ported it to build on Linux
so that I could test and use the /dev/mdesc driver.
