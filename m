From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 22 Jul 2020 03:30:07 +0000
Subject: Re: [PATCH][next] sparc: Use fallthrough pseudo-keyword
Message-Id: <80565ca0-587c-a623-3ee2-f833d2baa589@embeddedor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200707172436.GA27273@embeddedor>
 <20200721.182941.998193142437529225.davem@davemloft.net>
In-Reply-To: <20200721.182941.998193142437529225.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>, gustavoars@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 7/21/20 20:29, David Miller wrote:
> From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Date: Tue, 7 Jul 2020 12:24:36 -0500
>=20
>> Replace the existing /* fall through */ comments and its variants with
>> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
>> fall-through markings when it is the case.
>>
>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highl=
ight=FAllthrough#implicit-switch-case-fall-through
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>=20
> Applied.
>=20

Thanks, Dave.

--
Gustavo
