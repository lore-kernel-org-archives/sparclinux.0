From: David Miller <davem@davemloft.net>
Date: Mon, 31 Jul 2017 22:06:32 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <20170731.150632.885106324164202893.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqzkUqWsHgw8eNHF4E_wi5a6d=hJnmEtm5omsw42tHAw+Q@mail.gmail.com>
        <20170731.145151.571917275997786929.davem@davemloft.net>
        <CADxRZqz+oQn8=Q3RDtfko9ctP1RE41XnsVP3H8RXJuE9m=VPLw@mail.gmail.com>
In-Reply-To: <CADxRZqz+oQn8=Q3RDtfko9ctP1RE41XnsVP3H8RXJuE9m=VPLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matorola@gmail.com
Cc: mikpelinux@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 1 Aug 2017 01:01:47 +0300

> I don't know how to run on a running kernel , but as I understood:
> 
> root@v215:strace# gzip -dc /boot/vmlinuz-4.12.0 > vmlinux
> root@v215:strace# gdb -q vmlinux
> Reading symbols from vmlinux...(no debugging symbols found)...done.
> (gdb) x/20i 0x49b294 - 16

Unfortunately you need to do this on the build kernel image before it
has been stripped of all of it's symbols.

Mikael, you built your kernels right?

Go into one of your OOPS's and extract the "RPC: " hex value, and run
the gdb command:

bash$ cd src/linux
bash$ gdb ./vmlinux
(gdb) x/10i 0x${RPC_HEX_VALUE} - 16

Thanks.


