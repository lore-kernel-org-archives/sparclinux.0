From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 19 Nov 2018 11:05:02 +0000
Subject: Re: [PATCH net-next 0/6] Remove VLAN.CFI overload
Message-Id: <6d7de753-7e53-d980-e357-b1af2495cb7e@iogearbox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
 <20181110.134758.693752342395888727.davem@davemloft.net>
In-Reply-To: <20181110.134758.693752342395888727.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>, mirq-linux@rere.qmqm.pl
Cc: netdev@vger.kernel.org, ast@kernel.org, benh@kernel.crashing.org, jhogan@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paul.burton@mips.com, paulus@samba.org, ralf@linux-mips.org, sparclinux@vger.kernel.org

On 11/10/2018 10:47 PM, David Miller wrote:
> From: Micha=A9=A9 Miros=A9=A9aw <mirq-linux@rere.qmqm.pl>
> Date: Sat, 10 Nov 2018 19:58:29 +0100
>=20
>> Fix BPF code/JITs to allow for separate VLAN_PRESENT flag
>> storage and finally move the flag to separate storage in skbuff.
>>
>> This is final step to make CLAN.CFI transparent to core Linux
>> networking stack.
>>
>> An #ifdef is introduced temporarily to mark fragments masking
>> VLAN_TAG_PRESENT. This is removed altogether in the final patch.
>=20
> Daniel and Alexei, please review.

Sorry, was completely swamped due to plumbers, just getting to it now.
