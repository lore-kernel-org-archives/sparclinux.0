From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 02 Nov 2017 06:14:21 +0000
Subject: Re: [PATCH] sparc: pass endianness info to sparse
Message-Id: <CAMHZB6GHSDG_jJMAEJgaUtOfWs3T1qbcp6OxZ6QNUe3MOTgX=w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171031172210.9990-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20171031172210.9990-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Nov 2, 2017 at 6:41 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Luc.

Hi,

>> +CHECKFLAGS     += -mbig-endian
>> +
>
> You have added a new assignment to CHECKFLAGS because this
> options is the same for sparc32 and sparc64, which is fine.
>
> But could you then in the same patch
> also move the assingmnet to -D__sparc__ this place, as this is also
> a common option for sparc32 and sparc64.
> As it is after your patch we have common options duplicated (__sparc__)
> and in their own assignment (-mbig-endian).
> This is inconsistent and may confuse the next reader.

Yes, I agree but it seems a bit strange to me to do that in the same patch.
I suppose it doesn't matter much for such small patch, anyway.

-- Luc
