From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 09 Sep 2014 18:39:34 +0000
Subject: Re: [PATCH 3/3] sparc/uapi: Add definition of TIOC[SG]RS485
Message-Id: <CAPybu_0CLYp25+UXUSbQJck7ChAzBTTpQpZOhB8pK2B4pBP6sA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1410286110-24956-1-git-send-email-ricardo.ribalda@gmail.com> <20140909.112640.131028033967197328.davem@davemloft.net>
In-Reply-To: <20140909.112640.131028033967197328.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

Hello David

Thanks for you comments, I thought it was a good idea that the same
ioctl had the same value on all the arch, sorry to make a mess on your
file :)

I have just resend a v2 of the patch.

Regards!

On Tue, Sep 9, 2014 at 8:26 PM, David Miller <davem@davemloft.net> wrote:
> From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Date: Tue,  9 Sep 2014 20:08:30 +0200
>
>> diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
>> index 897d172..4e1c5da 100644
>> --- a/arch/sparc/include/uapi/asm/ioctls.h
>> +++ b/arch/sparc/include/uapi/asm/ioctls.h
>> @@ -24,6 +24,8 @@
>>  #define TIOCGPKT     _IOR('T', 0x38, int) /* Get packet mode state */
>>  #define TIOCGPTLCK   _IOR('T', 0x39, int) /* Get Pty lock state */
>>  #define TIOCGEXCL    _IOR('T', 0x40, int) /* Get exclusive mode state */
>> +#define TIOCGRS485   0x542E
>> +#define TIOCSRS485   0x542F
>
> Please follow the ioctl numbering scheme used by the particular
> architecture UAPI file you are editing.
>
> Since Sparc here is using incrementing _IO*() values, including the type
> for the object passed in/out of the ioctl, you should do similarly for
> TIOC{G,S}RS485.



-- 
Ricardo Ribalda
