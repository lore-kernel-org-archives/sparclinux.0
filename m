From: crn@netunix.com
Date: Wed, 16 Feb 2011 23:35:12 +0000
Subject: Re: Sun Ultra2 (enterprise) finally failed... (stupid eprom)
Message-Id: <alpine.LNX.2.00.1102162330560.5107@web1.netunix.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-2024815769-1811996760-1297899314=:5107"
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTim2qJw9tvztMSiY1+1nS3UUOfsR7ZQEX1K5rFwB@mail.gmail.com>
In-Reply-To: <AANLkTim2qJw9tvztMSiY1+1nS3UUOfsR7ZQEX1K5rFwB@mail.gmail.com>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2024815769-1811996760-1297899314=:5107
Content-Type: TEXT/PLAIN; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable


Do not dispair.
There is a FAQ on the eeprom/nvram including how to fix and reprogram=20
them.
http://www.squirrel.com/sun-nvram-hostid.faq.html


On Tue, 15 Feb 2011, David Miller wrote:

> From: Julian Calaby <julian.calaby@gmail.com>
> Date: Wed, 16 Feb 2011 11:02:15 +1100
>
>> On Wed, Feb 16, 2011 at 10:38, Leif Sawyer <lsawyer@gci.com> wrote:
>>> My poor 14yo sparc finally bit the dust --
>>> well, actually, the battery in the prom finally gave up and lost
>>> its config during the last power-cycle.
>>>
>>> So, now I'm looking for a replacement M48T59Y-70PC1 =A0from some reputi=
ble dealer,
>>> and preferably one that one cost an extra 50$ just to ship to Alaska...
>>
>> There is a hack to replace the battery. [1] I've got a SSLX with a
>> similar issue which needs that, but haven't gotten around to doing it
>> yet. Also remember that you're going to have to re-program the chip as
>> it contains some important config information.
>
> Whilst sparc32 chips absolutely need this config information set
> properly (it contains the system type value), on sparc64 systems it
> only really carries the date and the ethernet address.
>
> And then of course the checksum has to be set correctly after
> you've filled it in :-)
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
---2024815769-1811996760-1297899314=:5107--
