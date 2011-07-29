From: Ghitulete Razvan <razvan.ghitulete@gmail.com>
Date: Fri, 29 Jul 2011 10:07:14 +0000
Subject: Re: Silo Bootloader
Message-Id: <CAMHygWJi+-TRVXpPBOBsj+=dyqj=6SB+XeANcL-qWSV2m1Jbig@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMHygW+HcnXzvsxsC6M_9COsOWOdn490OtbBobdrWAGTb3JNrQ@mail.gmail.com>
In-Reply-To: <CAMHygW+HcnXzvsxsC6M_9COsOWOdn490OtbBobdrWAGTb3JNrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've manage to narrow it down a little, and it happens I get that
error after I try to save the openfirmware cif_address in memory,
which is kind of awkward, as the whole binary is no bigger than
several kb, after being converted to an a.out. So there shouldn't be
any overflow of the mapped memory, which should be 8mb. Does anybody
have any suggestions?

-- 
Razvan Ghitulete
Universitatea Politehnica Bucuresti
