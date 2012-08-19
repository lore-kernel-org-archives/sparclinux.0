From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 04:51:07 +0000
Subject: Re: SILO fails to read silo.conf from EXT4 FS
Message-Id: <20120818.215107.596093976844482652.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5015201A.8060309@gentoo.org>
In-Reply-To: <5015201A.8060309@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Ra=FAl Porcel <armin76@gentoo.org>
Date: Sat, 18 Aug 2012 18:02:40 +0200

> On 08/16/12 05:17, David Miller wrote:
>> From: Ra=FAl Porcel<armin76@gentoo.org>
>> Date: Sun, 29 Jul 2012 13:35:54 +0200
>>
>>> With the rewrite of the e2fs part of SILO, its unable to read
>>> /etc/silo.conf from an EXT4 FS. It can read from EXT2 and EXT3,
>>> though.
>>
>> There are some minor errors in the extent leaf traversal, can you try
>> this patch below?
>>
>> If this fails I'll give you a patch which adds some tracing so we can
>> diagnose this further.
>>
>> Thanks!
>>
>>[snip]
>=20
> That fixed it.

And now committed to git, thanks a lot for testing.
