From: David Miller <davem@davemloft.net>
Date: Thu, 08 Jun 2017 14:02:22 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code
Message-Id: <20170608.100222.1573468093040905016.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <877f0z6oig.fsf@concordia.ellerman.id.au>
        <28d6c874-4653-b15d-39b7-57a032abc9c6@oracle.com>
        <CAK8P3a1WfU9V1k2r=TfJSVRTymuD8n2hkJDr6u1KcmC_scAZMA@mail.gmail.com>
In-Reply-To: <CAK8P3a1WfU9V1k2r=TfJSVRTymuD8n2hkJDr6u1KcmC_scAZMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de
Cc: babu.moger@oracle.com, mpe@ellerman.id.au, geert@linux-m68k.org, peterz@infradead.org, mingo@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Jun 2017 10:01:59 +0200

> I would also suggest adding a sanity check like

Hmm, but this will kill the build for non-fixed endian architectures
won't it?
