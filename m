From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 17:32:02 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.103202.1369172773546547266.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 08:53:50 +0200

> On 09/18/2017 06:43 PM, David Miller wrote:
>>> Also, since mdesc is basically a tree it maps well to a filesystem
>>> structure like sysfs.
>> 
>> We don't export identical information two different ways in the kernel.
> 
> I agree.
> 
>> We have /dev/mdesc already.
> 
> Is there anything that prevents us from removing it?

Yes, I and others have tools like mdlint that we use every day?!?!
