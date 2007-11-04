From: Bernd Zeimetz <bernd@bzed.de>
Date: Sun, 04 Nov 2007 23:14:45 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <472E5265.3040200@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Bernd Zeimetz <bernd@bzed.de>
> Date: Sun, 04 Nov 2007 20:55:20 +0100
> 
>> So I'm not sure if the result is really useful for you - if not just let
>> me know. I've attached the last ~10-20 sysrq-g outputs - as it was
>> running in a loop I have a ton of them. In case you're wondering: http
>> is aptitude's http method.
> 
> The http module is stuck in a different place, I'll try to
> see if I can make sense of it.

In the meantime I'll build an aptitude which should exit after running
trough the part which crashed usually, so it should be possible to run
it in a loop...

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
