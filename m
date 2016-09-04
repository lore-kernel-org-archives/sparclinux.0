From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 04 Sep 2016 04:33:11 +0000
Subject: Re: [PATCH 2/4] sparc: bpf_jit: Move four assignments in bpf_jit_compile()
Message-Id: <a6afaf8a-837e-6cc3-fdec-3a37f0e731d5@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
 <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
 <2179bf7c-9878-adf7-da97-2746d5aa3d34@users.sourceforge.net>
 <CAGRGNgWXdzvfL4wdM2uQr7DRbJgCuY0O-jRmSGhqfbPBZGS2Aw@mail.gmail.com>
In-Reply-To: <CAGRGNgWXdzvfL4wdM2uQr7DRbJgCuY0O-jRmSGhqfbPBZGS2Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Julian Calaby <julian.calaby@gmail.com>
Cc: sparclinux <sparclinux@vger.kernel.org>, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

>> Date: Sat, 3 Sep 2016 17:45:28 +0200
>>
>> Move the assignments for four local variables a bit at the beginning
>> so that they will only be performed if a corresponding memory allocation
>> succeeded by this function.
…
>> @@ -362,10 +362,10 @@ do {      *prog++ = BR_OPC | WDISP22(OFF);                \
>>
>>  void bpf_jit_compile(struct bpf_prog *fp)
>>  {
>> -       unsigned int cleanup_addr, proglen, oldproglen = 0;
>> -       u32 temp[8], *prog, *func, seen = 0, pass;
>> -       const struct sock_filter *filter = fp->insns;
>> -       int i, flen = fp->len, pc_ret0 = -1;
>> +       unsigned int cleanup_addr, proglen, oldproglen;
>> +       u32 temp[8], *prog, *func, seen, pass;
>> +       const struct sock_filter *filter;
>> +       int i, flen = fp->len, pc_ret0;
>>         unsigned int *addrs;
>>         void *image;
>>
>> @@ -385,6 +385,10 @@ void bpf_jit_compile(struct bpf_prog *fp)
>>         }
>>         cleanup_addr = proglen; /* epilogue address */
>>         image = NULL;
>> +       filter = fp->insns;
>> +       oldproglen = 0;
>> +       pc_ret0 = -1;
>> +       seen = 0;
>>         for (pass = 0; pass < 10; pass++) {
>>                 u8 seen_or_pass0 = (pass = 0) ? (SEEN_XREG | SEEN_DATAREF | SEEN_MEM) : seen;
…
> If you were moving the assignments on declaration onto separate lines
> at the top of the file then ok,

I see another software design option where the transformation result might be looking
more pleasing for you again.


> but why all the way down here?

* How do you think about the reason I gave in the short commit message?

* Are you interested in an other software refactoring instead?
  http://refactoring.com/catalog/reduceScopeOfVariable.html

  Would you eventually like to move the source code for this for loop into another function?
  http://refactoring.com/catalog/extractMethod.html

Regards,
Markus
