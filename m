From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 08 Jan 2021 20:20:43 +0000
Subject: Re: [patch V3 13/37] mips/mm/highmem: Switch to generic kmap atomic
Message-Id: <JUTMMQ.NNFWKIUV7UUJ1@crapouillou.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: juri.lelli@redhat.com, linux-aio@kvack.org, airlied@linux.ie, nouveau@lists.freedesktop.org, bigeasy@linutronix.de, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, bsegall@google.com, jcmvbkbc@gmail.com, ray.huang@amd.com, paulus@samba.org, kraxel@redhat.com, sparclinux@vger.kernel.org, deanbo422@gmail.com, hch@lst.de, paulmck@kernel.org, mpe@ellerman.id.au, x86@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, airlied@redhat.com, linux-snps-arc@lists.infradead.org, linux-mm@kvack.org, mgorman@suse.de, linux-xtensa@linux-xtensa.org, arnd@arndb.de, intel-gfx@lists.freedesktop.org, sroland@vmware.com, josef@toxicpanda.com, rostedt@goodmis.org, torvalds@linuxfoundation.org, green.hu@gmail.com, dsterba@suse.com, virtualization@lists.linux-foundation.org, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, chris@zankel.net, monstr@monstr.eu, tsbogend@alpha.franken.de, nickhu@andestech.com, clm@fb.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, bcrl@kvack.org, spice-devel@lists.freedesktop.org, vgupta@synopsys.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, bristot@redhat.com, davem@davemloft.net, linux-btrfs@vger.kernel.org, viro@zeniv.linux.org.uk

Hi Thomas,

5.11 does not boot anymore on Ingenic SoCs, I bisected it to this 
commit.

Any idea what could be happening?

Cheers,
-Paul
