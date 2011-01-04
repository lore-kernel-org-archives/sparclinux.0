From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 04 Jan 2011 19:51:57 +0000
Subject: Re: [RFC 1/8] sparc: prom: Sanitize return value from prom_nbputchar()
Message-Id: <AANLkTimfoD5uq=+dx_RDTpEmPU6fMtbjQTCXswV++bzt@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BBC6.3080809@julian.is-a-geek.org>
In-Reply-To: <4CF9BBC6.3080809@julian.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, Jan 5, 2011 at 04:50, David Miller <davem@davemloft.net> wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
> Date: Tue, 04 Jan 2011 15:42:45 +0100
>
>> David Miller wrote:
>>
>>>From: Julian Calaby <jcalaby@julian.is-a-geek.org>
>>>Date: Sat, 04 Dec 2010 14:55:50 +1100
>>>
>>>
>>>>Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
>>>>
>>>
>>>Applied.
>>>
>>
>> I think this patch breaks the backwards compatability...
>
> Backwards compatability for who? =A0There is one and only one caller
> of this function, and it is marked static and not exported to any
> other piece of code in the tree.

The other point is that sparc64's version works like this, so why
should sparc32's version be different?

--=20

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
