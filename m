From: David Miller <davem@davemloft.net>
Date: Sat, 17 Nov 2018 05:11:35 +0000
Subject: Re: [PATCH net-next 0/6] Remove VLAN.CFI overload
Message-Id: <20181116.211135.178846692709588415.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
        <20181110.134758.693752342395888727.davem@davemloft.net>
        <CAADnVQKzo_85bUPXnaqds0MxzrOu_BJwnZx25CbsNrjV=DHC3w@mail.gmail.com>
In-Reply-To: <CAADnVQKzo_85bUPXnaqds0MxzrOu_BJwnZx25CbsNrjV=DHC3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alexei.starovoitov@gmail.com
Cc: mirq-linux@rere.qmqm.pl, netdev@vger.kernel.org, ast@kernel.org, benh@kernel.crashing.org, daniel@iogearbox.net, jhogan@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paul.burton@mips.com, paulus@samba.org, ralf@linux-mips.org, sparclinux@vger.kernel.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 Nov 2018 19:51:55 -0800

> Michal, could you please explain the reasoning?

By treating VLAN.CFI specially as "VLAN TAG PRESENT" we prevent
the usage of certain VLAN ID encodings.

So he's trying to get rid of VLAN_TAG_PRESENT completely and this
was the final patch series necessary to accomplish that.
