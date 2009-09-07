From: =?ISO-8859-1?Q?S=E9bastien_Bernard?= <seb@frankengul.org>
Date: Mon, 07 Sep 2009 20:12:53 +0000
Subject: Re: Cassini problem
Message-Id: <4AA56945.3070305@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

S=E9bastien Bernard a =E9crit :
> I'm running on linux-image-2.6.29-2-sparc64-smp on an U60 (2x Uii=20
> 450mhz).
>
> I'm on SID and I had quite a lot of problems with my ethernet controler.
>
> Here's the references of the controler :
> 0000:00:02.0 Ethernet controller: National Semiconductor Corporation=20
> DP83065 [Saturn] 10/100/1000 Ethernet Controller (rev 30)
>
> PCI Id is 100b:0035.
>
> The Kernel reported the following problem :
> [1684214.274488] eth1: Link down
> [1684214.274512] eth1:reset called in cas_abnormal_irq [0xa721000]
> [1684220.889911] eth1: Link up at 1000 Mbps, full-duplex.
> [1684220.889937] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on:=20
> 11776)
> [1684221.081675] eth1: Link down
> [1684221.081694] eth1:reset called in cas_abnormal_irq [0x21000]
> [1684236.586802] eth1: Link up at 100 Mbps, full-duplex.
> [1684236.586826] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on:=20
> 11776)
> [1707485.501429] eth1: Link down
> [1707485.501448] eth1:reset called in cas_abnormal_irq [0x4621000]
> [1707505.313339] eth1: Link up at 1000 Mbps, full-duplex.
> [1707505.313363] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on:=20
> 11776)
> [1707505.321494] eth1: Link down
> [1707505.321511] eth1:reset called in cas_abnormal_irq [0x21000]
> [1707509.789804] eth1: Link up at 100 Mbps, full-duplex.
> [1707509.789826] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on:=20
> 11776)
>
>
> The machine was working ok with 2.6.28-7-smp kernel.
> Transfert are slow (~ 4-7 MBytes/s) and pauses at regular times.
>
> On 2.6.30-1, it goes worse. Link goes down and up every few seconds,=20
> making the work
> a nightmare.
>
> Is this a know problem or should I report a bug for this ?
>
>    Seb
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I did a little investigation. The driver involved is the cassini.
The updated driver doesn't want to negociate 1000 Mbps full duplex as=20
before.
Did a manual compile of a vanilla 2.6.30.5 kernel and got the same results.
100Mbp/FD negociation.
Each time the link is loaded (a.k.a. transfer a consequent file), the=20
transfer stall several times and
overall I get a 3Mbyte/s average transfer (before I was getting full=20
100mb link saturated i.e. near 11Mbytes/s).
During the transfer, one can see one the console the following warnings :

[ 7698.289666] eth1: Link down
[ 7698.294095] eth1:reset called in cas_abnormal_irq [0xfa1000]
[ 7709.312133] eth1: Link up at 1000 Mbps, full-duplex.
[ 7709.316612] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on: 11776)
[ 7710.247998] eth1: Link down
[ 7710.252406] eth1:reset called in cas_abnormal_irq [0x5a1000]
[ 7714.656684] eth1: Link up at 1000 Mbps, full-duplex.
[ 7714.661096] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on: 11776)
[ 7714.878336] eth1: Link down
[ 7714.882719] eth1:reset called in cas_abnormal_irq [0xa1000]
[ 7719.285192] eth1: Link up at 1000 Mbps, full-duplex.
[ 7719.289763] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on: 11776)
[ 7719.582541] eth1: Link down
[ 7719.587005] eth1:reset called in cas_abnormal_irq [0x321000]
[ 7723.989687] eth1: Link up at 100 Mbps, full-duplex.
[ 7723.994047] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on: 11776)


I suspect either :  =20
    a- some kind of firmware misbehavior since the 2.6.28 which was=20
working ok got the same problem.
    b- a hardware problem

    Seb

