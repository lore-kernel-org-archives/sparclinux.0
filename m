Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710899;
	b=Q1QWgNc64Kk9dYyNm4WIpGqd25oFKdeoPKwqqFqrtvCpRn0ZQgEL7H9xO19GhF2UX8ib
	 y5jaQ6zjKqAHKh8AP2WzHIaVwJsvGedRdJuhOpqeM2l4Dq9auhCVLC2dyPqQcxMfPCD92
	 jE9SgzEhpGBs/Ivp7u4HPOS+rtChpC3pyDrhzI1EQmCjrjSDpgQioQPC/BF5xB09JrvHG
	 c5tjel5TJJlxJXn96NMBm3LfQcBN1Me/MiRpRsGzoEtJ97PvYtsDxHohCl0JOzBAiJUuk
	 XpFA/RpIax7HhjF4SpIkXt0u3by/9QjoA/meuAPZDxxbsc+BY4UlLheIps8TTv0RSIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710899;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MXlTLVrJ+8VyZnT5b9Rq3zNGNivlya/OsfintA2OPZU=;
	b=3pX6ycGhJ7sf2Sn0VtCqpM8mgvlthjV0QC1oFcIzqyB84gSVtXE3wJUxC3461d3ZRywv
	 +hpWLLc1/ECbS5h0zz7AdhUCBaCuC2znr4/WUbuiHBP6D2yNtF1kXK6kK+DETxsJuF+Mb
	 KFW+TW8Z58A/4VDb7BGfRqGPxmA/Yp/e+/XKjj12zeoY13AzUg+X7FTHwzwQNobPjKwlK
	 PCS3LtNIMFQdyzXz0RQrINwLXbnq+onaCgoOibFswTLZbaYhwSY0xVYXdQ4xtSi83Y+MU
	 UCdk+Vk0t7vf0aI50Ltn78PDKYwtpaVPNgqlcrdJOBSAteX0mePx5l/EqItFD4zIxRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCOphDhg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA9F606D804;
	Tue,  3 Nov 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCOphDhg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D431F00A02;
	Tue,  3 Nov 2026 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710899;
	bh=MXlTLVrJ+8VyZnT5b9Rq3zNGNivlya/OsfintA2OPZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCOphDhgwQ8NGxMZqa2+B+NPzkOmO1szZRb+kGZkqho8TLMxoDAdJZPwJhNpB+IuN
	 pr/x3sk6mMUMpNrYL7weXFezxfyS0R9IUgVv+I3lCv/T3/CIzeBua199bTL7Lm6c0+
	 /PJB7T6/XEnrH7/1ANUGOHOy3Z+kbDaSvKcRuKRIaqUpfqn5nVjvV05pDD641Ufk0T
	 qWUaM0tkWNr19cF4q+v7V5wymrt4GNDg4QjRpbUEkOfQJDP8iIKqloQI7wjkq+V6p7
	 Cc/YoEACpfpvgudlj0SsAqJ2yLZe+AH8xqDhxXbAjLvkFAJAPfvBC/YbXC4u32oJE5
	 eN1MUnkMWew5Q==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	=?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] selftests: report per-suite build results without failing the build
Date: Tue,  3 Nov 2026 08:01:25 -0500
Message-ID: <20261103130131.4069212-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014200115.1363363-1-sashal@kernel.org>
References: <20261014200115.1363363-1-sashal@kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah,

Thanks for taking 1/7 and 2/7. 3/7 through 7/7 are still pending and
still apply on 7.4-rc1. Catalin acked and Mark reviewed the arm64 one.

Without them a failed subdirectory in futex, arm64, riscv, powerpc or
sparc64 still gets lost, and for arm64 and riscv a failure in the last
subdirectory drops the whole suite from the install. Could you pick
them up?

-- 
Thanks,
Sasha
