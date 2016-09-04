From: David Miller <davem@davemloft.net>
Date: Sun, 04 Sep 2016 06:06:07 +0000
Subject: Re: [PATCH 4/4] sparc: bpf_jit: Rename jump labels in bpf_jit_compile()
Message-Id: <20160903.230607.1667562673788737377.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
        <054ff9e1-2b84-904b-5f92-55746292916e@users.sourceforge.net>
        <57CAFFDC.4030606@iogearbox.net>
In-Reply-To: <57CAFFDC.4030606@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: daniel@iogearbox.net
Cc: elfring@users.sourceforge.net, sparclinux@vger.kernel.org, adam.buchbinder@gmail.com, ast@kernel.org, rabin@rab.in, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, julia.lawall@lip6.fr, pbonzini@redhat.com

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sat, 03 Sep 2016 18:52:44 +0200

> On 09/03/2016 06:41 PM, SF Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Sat, 3 Sep 2016 18:14:19 +0200
>>
>> Adjust jump labels according to the current Linux coding style
>> convention.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> NAK, just noise.

And frankly I hate that leading space.
