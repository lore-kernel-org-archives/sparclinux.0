From: David Miller <davem@davemloft.net>
Date: Sat, 17 Nov 2018 03:26:44 +0000
Subject: Re: [PATCH net-next 0/6] Remove VLAN.CFI overload
Message-Id: <20181116.192644.2178661017383340711.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: mirq-linux@rere.qmqm.pl
Cc: netdev@vger.kernel.org, ast@kernel.org, benh@kernel.crashing.org, daniel@iogearbox.net, jhogan@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paul.burton@mips.com, paulus@samba.org, ralf@linux-mips.org, sparclinux@vger.kernel.org

From: Micha=A9=A9 Miros=A9=A9aw <mirq-linux@rere.qmqm.pl>
Date: Sat, 10 Nov 2018 19:58:29 +0100

> Fix BPF code/JITs to allow for separate VLAN_PRESENT flag
> storage and finally move the flag to separate storage in skbuff.
>=20
> This is final step to make CLAN.CFI transparent to core Linux
> networking stack.
>=20
> An #ifdef is introduced temporarily to mark fragments masking
> VLAN_TAG_PRESENT. This is removed altogether in the final patch.

Series applied, thank you.
