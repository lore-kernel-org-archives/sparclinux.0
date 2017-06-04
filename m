From: David Miller <davem@davemloft.net>
Date: Sun, 04 Jun 2017 20:22:26 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170604.162226.1986766921223996448.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170602.132809.1754806777743128355.davem@davemloft.net>
        <a2f74c42-5a3a-23ec-b8f9-7694f606b714@physik.fu-berlin.de>
        <20170604144044.GK26922@waldemar-brodkorb.de>
In-Reply-To: <20170604144044.GK26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wbx@openadk.org
Cc: glaubitz@physik.fu-berlin.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Waldemar Brodkorb <wbx@openadk.org>
Date: Sun, 4 Jun 2017 16:40:45 +0200

> Hi Adrian,
> John Paul Adrian Glaubitz wrote,
> 
>> On 06/02/2017 07:28 PM, David Miller wrote:
>> >> Isn't a bug in the kernel if an application is able to crash to the point
>> >> that the machine has to be hard-rebooted?
>> > 
>> > It can be a bug in the compiler too and not necessarily the kernel's
>> > fault which is what I think is happening in your case.
>> 
>> So, in your point of view it's perfectly fine if an application is able
>> to crash the whole kernel with just user privileges?
>> 
>> Shouldn't the kernel be able to cope with that?
> 
> I think he means your kernel you are running might be miscompiled
> with gcc 7.1.

That's exactly what I am saying.
