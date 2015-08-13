From: wangyijing <wangyijing@huawei.com>
Date: Thu, 13 Aug 2015 10:28:58 +0000
Subject: Re: bisected: boot hang on sparc64 after PCIe changes
Message-Id: <55CC716A.8070406@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1508122118210.18637@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1508122118210.18637@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org



在 2015/8/13 18:15, Meelis Roos 写道:
>> 4.1.0 worked but 4.2-rc2 hangs on boot after switching console but 
>> before reprinting dmesg to the new console. That happens on 2 of my 
>> sparc64's: T2000 and V245. These happen to have the PCIe slot names in 
>> sysfs so it may be related. The following commit breaks the boot at 
>> least on V245 where I performed the bisection:
> 
> Just verified that T2000 is also hanging because of the same commit.

Thanks for your information, could you capture the crash Oops calltrace ?


> 

