
bin/main.elf:     file format elf32-littlearm


Disassembly of section .text:

08000188 <m_abs>:
 8000188:	ee07 0a90 	vmov	s15, r0
 800018c:	eef5 7ac0 	vcmpe.f32	s15, #0.0
 8000190:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 8000194:	bf48      	it	mi
 8000196:	eef1 7a67 	vnegmi.f32	s15, s15
 800019a:	ee17 0a90 	vmov	r0, s15
 800019e:	4770      	bx	lr

080001a0 <m_min>:
 80001a0:	ee07 0a10 	vmov	s14, r0
 80001a4:	ee07 1a90 	vmov	s15, r1
 80001a8:	eeb4 7ae7 	vcmpe.f32	s14, s15
 80001ac:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 80001b0:	bf54      	ite	pl
 80001b2:	ee17 0a90 	vmovpl	r0, s15
 80001b6:	ee17 0a10 	vmovmi	r0, s14
 80001ba:	4770      	bx	lr

080001bc <getBatteryVoltage>:
 80001bc:	2002      	movs	r0, #2
 80001be:	f001 bf6f 	b.w	80020a0 <adc_read>

080001c2 <read_i2c_adc>:
 80001c2:	b538      	push	{r3, r4, r5, lr}
 80001c4:	f002 fbf6 	bl	80029b4 <i2cStart>
 80001c8:	209b      	movs	r0, #155	; 0x9b
 80001ca:	f002 fc11 	bl	80029f0 <i2cWrite>
 80001ce:	2801      	cmp	r0, #1
 80001d0:	d10d      	bne.n	80001ee <read_i2c_adc+0x2c>
 80001d2:	f002 fc35 	bl	8002a40 <i2cRead>
 80001d6:	4605      	mov	r5, r0
 80001d8:	2000      	movs	r0, #0
 80001da:	f002 fc31 	bl	8002a40 <i2cRead>
 80001de:	4604      	mov	r4, r0
 80001e0:	f002 fbf7 	bl	80029d2 <i2cStop>
 80001e4:	f3c4 0087 	ubfx	r0, r4, #2, #8
 80001e8:	ea40 1085 	orr.w	r0, r0, r5, lsl #6
 80001ec:	bd38      	pop	{r3, r4, r5, pc}
 80001ee:	f002 fbf0 	bl	80029d2 <i2cStop>
 80001f2:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
 80001f6:	bd38      	pop	{r3, r4, r5, pc}

080001f8 <getChargingVoltage>:
 80001f8:	b508      	push	{r3, lr}
 80001fa:	f7ff ffe2 	bl	80001c2 <read_i2c_adc>
 80001fe:	1c43      	adds	r3, r0, #1
 8000200:	bf1f      	itttt	ne
 8000202:	f640 43e4 	movwne	r3, #3300	; 0xce4
 8000206:	4358      	mulne	r0, r3
 8000208:	0a80      	lsrne	r0, r0, #10
 800020a:	0040      	lslne	r0, r0, #1
 800020c:	bd08      	pop	{r3, pc}

0800020e <rgb_i2c_delay>:
 800020e:	bf00      	nop
 8000210:	4770      	bx	lr

08000212 <RGBSetLowSDA>:
 8000212:	b513      	push	{r0, r1, r4, lr}
 8000214:	2301      	movs	r3, #1
 8000216:	2203      	movs	r2, #3
 8000218:	24f0      	movs	r4, #240	; 0xf0
 800021a:	f88d 3004 	strb.w	r3, [sp, #4]
 800021e:	f88d 3006 	strb.w	r3, [sp, #6]
 8000222:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8000226:	2300      	movs	r3, #0
 8000228:	4669      	mov	r1, sp
 800022a:	f88d 2005 	strb.w	r2, [sp, #5]
 800022e:	f88d 3007 	strb.w	r3, [sp, #7]
 8000232:	9400      	str	r4, [sp, #0]
 8000234:	f002 fae2 	bl	80027fc <GPIO_Init>
 8000238:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 800023c:	851c      	strh	r4, [r3, #40]	; 0x28
 800023e:	f7ff ffe6 	bl	800020e <rgb_i2c_delay>
 8000242:	b002      	add	sp, #8
 8000244:	bd10      	pop	{r4, pc}

08000246 <RGBSetHighSDA>:
 8000246:	b513      	push	{r0, r1, r4, lr}
 8000248:	2300      	movs	r3, #0
 800024a:	2203      	movs	r2, #3
 800024c:	24f0      	movs	r4, #240	; 0xf0
 800024e:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8000252:	4669      	mov	r1, sp
 8000254:	f88d 3004 	strb.w	r3, [sp, #4]
 8000258:	f88d 2005 	strb.w	r2, [sp, #5]
 800025c:	f88d 3007 	strb.w	r3, [sp, #7]
 8000260:	9400      	str	r4, [sp, #0]
 8000262:	f002 facb 	bl	80027fc <GPIO_Init>
 8000266:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 800026a:	619c      	str	r4, [r3, #24]
 800026c:	f7ff ffcf 	bl	800020e <rgb_i2c_delay>
 8000270:	b002      	add	sp, #8
 8000272:	bd10      	pop	{r4, pc}

08000274 <RGBSetLowSCL>:
 8000274:	4b02      	ldr	r3, [pc, #8]	; (8000280 <RGBSetLowSCL+0xc>)
 8000276:	f44f 5200 	mov.w	r2, #8192	; 0x2000
 800027a:	851a      	strh	r2, [r3, #40]	; 0x28
 800027c:	f7ff bfc7 	b.w	800020e <rgb_i2c_delay>
 8000280:	48000800 	.word	0x48000800

08000284 <RGBSetHighSCL>:
 8000284:	4b02      	ldr	r3, [pc, #8]	; (8000290 <RGBSetHighSCL+0xc>)
 8000286:	f44f 5200 	mov.w	r2, #8192	; 0x2000
 800028a:	619a      	str	r2, [r3, #24]
 800028c:	f7ff bfbf 	b.w	800020e <rgb_i2c_delay>
 8000290:	48000800 	.word	0x48000800

08000294 <rgb_i2c_init>:
 8000294:	b573      	push	{r0, r1, r4, r5, r6, lr}
 8000296:	f44f 5300 	mov.w	r3, #8192	; 0x2000
 800029a:	2400      	movs	r4, #0
 800029c:	9300      	str	r3, [sp, #0]
 800029e:	2603      	movs	r6, #3
 80002a0:	2301      	movs	r3, #1
 80002a2:	4669      	mov	r1, sp
 80002a4:	4812      	ldr	r0, [pc, #72]	; (80002f0 <rgb_i2c_init+0x5c>)
 80002a6:	f88d 3004 	strb.w	r3, [sp, #4]
 80002aa:	25f0      	movs	r5, #240	; 0xf0
 80002ac:	f88d 6005 	strb.w	r6, [sp, #5]
 80002b0:	f88d 4006 	strb.w	r4, [sp, #6]
 80002b4:	f88d 4007 	strb.w	r4, [sp, #7]
 80002b8:	f002 faa0 	bl	80027fc <GPIO_Init>
 80002bc:	4669      	mov	r1, sp
 80002be:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 80002c2:	9500      	str	r5, [sp, #0]
 80002c4:	f88d 4004 	strb.w	r4, [sp, #4]
 80002c8:	f88d 6005 	strb.w	r6, [sp, #5]
 80002cc:	f88d 4007 	strb.w	r4, [sp, #7]
 80002d0:	f002 fa94 	bl	80027fc <GPIO_Init>
 80002d4:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 80002d8:	4629      	mov	r1, r5
 80002da:	f002 fad1 	bl	8002880 <GPIO_SetBits>
 80002de:	f7ff ffd1 	bl	8000284 <RGBSetHighSCL>
 80002e2:	f7ff ff96 	bl	8000212 <RGBSetLowSDA>
 80002e6:	f7ff ffae 	bl	8000246 <RGBSetHighSDA>
 80002ea:	b002      	add	sp, #8
 80002ec:	bd70      	pop	{r4, r5, r6, pc}
 80002ee:	bf00      	nop
 80002f0:	48000800 	.word	0x48000800

080002f4 <rgb_i2cStart>:
 80002f4:	b508      	push	{r3, lr}
 80002f6:	f7ff ffc5 	bl	8000284 <RGBSetHighSCL>
 80002fa:	f7ff ffa4 	bl	8000246 <RGBSetHighSDA>
 80002fe:	f7ff ffc1 	bl	8000284 <RGBSetHighSCL>
 8000302:	f7ff ff86 	bl	8000212 <RGBSetLowSDA>
 8000306:	f7ff ffb5 	bl	8000274 <RGBSetLowSCL>
 800030a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 800030e:	f7ff bf9a 	b.w	8000246 <RGBSetHighSDA>

08000312 <rgb_i2cStop>:
 8000312:	b508      	push	{r3, lr}
 8000314:	f7ff ffae 	bl	8000274 <RGBSetLowSCL>
 8000318:	f7ff ff7b 	bl	8000212 <RGBSetLowSDA>
 800031c:	f7ff ffb2 	bl	8000284 <RGBSetHighSCL>
 8000320:	f7ff ff77 	bl	8000212 <RGBSetLowSDA>
 8000324:	f7ff ffae 	bl	8000284 <RGBSetHighSCL>
 8000328:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 800032c:	f7ff bf8b 	b.w	8000246 <RGBSetHighSDA>

08000330 <rgb_i2cWrite>:
 8000330:	b538      	push	{r3, r4, r5, lr}
 8000332:	4605      	mov	r5, r0
 8000334:	2408      	movs	r4, #8
 8000336:	f7ff ff9d 	bl	8000274 <RGBSetLowSCL>
 800033a:	062b      	lsls	r3, r5, #24
 800033c:	d502      	bpl.n	8000344 <rgb_i2cWrite+0x14>
 800033e:	f7ff ff82 	bl	8000246 <RGBSetHighSDA>
 8000342:	e001      	b.n	8000348 <rgb_i2cWrite+0x18>
 8000344:	f7ff ff65 	bl	8000212 <RGBSetLowSDA>
 8000348:	3c01      	subs	r4, #1
 800034a:	f7ff ff9b 	bl	8000284 <RGBSetHighSCL>
 800034e:	006d      	lsls	r5, r5, #1
 8000350:	f014 04ff 	ands.w	r4, r4, #255	; 0xff
 8000354:	b2ed      	uxtb	r5, r5
 8000356:	d1ee      	bne.n	8000336 <rgb_i2cWrite+0x6>
 8000358:	f7ff ff8c 	bl	8000274 <RGBSetLowSCL>
 800035c:	f7ff ff73 	bl	8000246 <RGBSetHighSDA>
 8000360:	f7ff ff90 	bl	8000284 <RGBSetHighSCL>
 8000364:	f7ff ff86 	bl	8000274 <RGBSetLowSCL>
 8000368:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
 800036c:	f7ff bf4f 	b.w	800020e <rgb_i2c_delay>

08000370 <rgb_i2cRead>:
 8000370:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000372:	2300      	movs	r3, #0
 8000374:	700b      	strb	r3, [r1, #0]
 8000376:	704b      	strb	r3, [r1, #1]
 8000378:	708b      	strb	r3, [r1, #2]
 800037a:	70cb      	strb	r3, [r1, #3]
 800037c:	4606      	mov	r6, r0
 800037e:	460c      	mov	r4, r1
 8000380:	1ccf      	adds	r7, r1, #3
 8000382:	f7ff ff77 	bl	8000274 <RGBSetLowSCL>
 8000386:	f7ff ff5e 	bl	8000246 <RGBSetHighSDA>
 800038a:	2508      	movs	r5, #8
 800038c:	1e63      	subs	r3, r4, #1
 800038e:	f813 2f01 	ldrb.w	r2, [r3, #1]!
 8000392:	0052      	lsls	r2, r2, #1
 8000394:	42bb      	cmp	r3, r7
 8000396:	701a      	strb	r2, [r3, #0]
 8000398:	d1f9      	bne.n	800038e <rgb_i2cRead+0x1e>
 800039a:	f7ff ff73 	bl	8000284 <RGBSetHighSCL>
 800039e:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 80003a2:	8a1b      	ldrh	r3, [r3, #16]
 80003a4:	b29b      	uxth	r3, r3
 80003a6:	06d8      	lsls	r0, r3, #27
 80003a8:	bf42      	ittt	mi
 80003aa:	7822      	ldrbmi	r2, [r4, #0]
 80003ac:	f042 0201 	orrmi.w	r2, r2, #1
 80003b0:	7022      	strbmi	r2, [r4, #0]
 80003b2:	0699      	lsls	r1, r3, #26
 80003b4:	bf42      	ittt	mi
 80003b6:	7862      	ldrbmi	r2, [r4, #1]
 80003b8:	f042 0201 	orrmi.w	r2, r2, #1
 80003bc:	7062      	strbmi	r2, [r4, #1]
 80003be:	065a      	lsls	r2, r3, #25
 80003c0:	bf42      	ittt	mi
 80003c2:	78a2      	ldrbmi	r2, [r4, #2]
 80003c4:	f042 0201 	orrmi.w	r2, r2, #1
 80003c8:	70a2      	strbmi	r2, [r4, #2]
 80003ca:	061b      	lsls	r3, r3, #24
 80003cc:	bf42      	ittt	mi
 80003ce:	78e3      	ldrbmi	r3, [r4, #3]
 80003d0:	f043 0301 	orrmi.w	r3, r3, #1
 80003d4:	70e3      	strbmi	r3, [r4, #3]
 80003d6:	f7ff ff4d 	bl	8000274 <RGBSetLowSCL>
 80003da:	3d01      	subs	r5, #1
 80003dc:	d1d6      	bne.n	800038c <rgb_i2cRead+0x1c>
 80003de:	b10e      	cbz	r6, 80003e4 <rgb_i2cRead+0x74>
 80003e0:	f7ff ff17 	bl	8000212 <RGBSetLowSDA>
 80003e4:	f7ff ff4e 	bl	8000284 <RGBSetHighSCL>
 80003e8:	f7ff ff44 	bl	8000274 <RGBSetLowSCL>
 80003ec:	e8bd 40f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, lr}
 80003f0:	f7ff bf0d 	b.w	800020e <rgb_i2c_delay>

080003f4 <rgb_i2c_write_reg>:
 80003f4:	b570      	push	{r4, r5, r6, lr}
 80003f6:	4606      	mov	r6, r0
 80003f8:	460d      	mov	r5, r1
 80003fa:	4614      	mov	r4, r2
 80003fc:	f7ff ff7a 	bl	80002f4 <rgb_i2cStart>
 8000400:	4630      	mov	r0, r6
 8000402:	f7ff ff95 	bl	8000330 <rgb_i2cWrite>
 8000406:	4628      	mov	r0, r5
 8000408:	f7ff ff92 	bl	8000330 <rgb_i2cWrite>
 800040c:	4620      	mov	r0, r4
 800040e:	f7ff ff8f 	bl	8000330 <rgb_i2cWrite>
 8000412:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 8000416:	f7ff bf7c 	b.w	8000312 <rgb_i2cStop>

0800041a <rgb_i2c_read_reg>:
 800041a:	b570      	push	{r4, r5, r6, lr}
 800041c:	4604      	mov	r4, r0
 800041e:	460e      	mov	r6, r1
 8000420:	4615      	mov	r5, r2
 8000422:	f7ff ff67 	bl	80002f4 <rgb_i2cStart>
 8000426:	4620      	mov	r0, r4
 8000428:	f7ff ff82 	bl	8000330 <rgb_i2cWrite>
 800042c:	4630      	mov	r0, r6
 800042e:	f7ff ff7f 	bl	8000330 <rgb_i2cWrite>
 8000432:	f7ff ff5f 	bl	80002f4 <rgb_i2cStart>
 8000436:	f044 0001 	orr.w	r0, r4, #1
 800043a:	f7ff ff79 	bl	8000330 <rgb_i2cWrite>
 800043e:	4629      	mov	r1, r5
 8000440:	2000      	movs	r0, #0
 8000442:	f7ff ff95 	bl	8000370 <rgb_i2cRead>
 8000446:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 800044a:	f7ff bf62 	b.w	8000312 <rgb_i2cStop>

0800044e <lsm9ds0_uninit>:
 800044e:	b508      	push	{r3, lr}
 8000450:	20d4      	movs	r0, #212	; 0xd4
 8000452:	2120      	movs	r1, #32
 8000454:	2200      	movs	r2, #0
 8000456:	f002 fb1b 	bl	8002a90 <i2c_write_reg>
 800045a:	203c      	movs	r0, #60	; 0x3c
 800045c:	2120      	movs	r1, #32
 800045e:	2200      	movs	r2, #0
 8000460:	f002 fb16 	bl	8002a90 <i2c_write_reg>
 8000464:	203c      	movs	r0, #60	; 0x3c
 8000466:	2124      	movs	r1, #36	; 0x24
 8000468:	2200      	movs	r2, #0
 800046a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 800046e:	f002 bb0f 	b.w	8002a90 <i2c_write_reg>
	...

08000474 <lsm9ds0_read>:
 8000474:	b538      	push	{r3, r4, r5, lr}
 8000476:	2128      	movs	r1, #40	; 0x28
 8000478:	20d4      	movs	r0, #212	; 0xd4
 800047a:	f002 fb1c 	bl	8002ab6 <i2c_read_reg>
 800047e:	2129      	movs	r1, #41	; 0x29
 8000480:	4604      	mov	r4, r0
 8000482:	20d4      	movs	r0, #212	; 0xd4
 8000484:	f002 fb17 	bl	8002ab6 <i2c_read_reg>
 8000488:	ea44 2000 	orr.w	r0, r4, r0, lsl #8
 800048c:	4c43      	ldr	r4, [pc, #268]	; (800059c <lsm9ds0_read+0x128>)
 800048e:	b280      	uxth	r0, r0
 8000490:	81a0      	strh	r0, [r4, #12]
 8000492:	89a3      	ldrh	r3, [r4, #12]
 8000494:	8a62      	ldrh	r2, [r4, #18]
 8000496:	1a9b      	subs	r3, r3, r2
 8000498:	b29b      	uxth	r3, r3
 800049a:	212a      	movs	r1, #42	; 0x2a
 800049c:	20d4      	movs	r0, #212	; 0xd4
 800049e:	8323      	strh	r3, [r4, #24]
 80004a0:	f002 fb09 	bl	8002ab6 <i2c_read_reg>
 80004a4:	212b      	movs	r1, #43	; 0x2b
 80004a6:	4605      	mov	r5, r0
 80004a8:	20d4      	movs	r0, #212	; 0xd4
 80004aa:	f002 fb04 	bl	8002ab6 <i2c_read_reg>
 80004ae:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 80004b2:	b280      	uxth	r0, r0
 80004b4:	81e0      	strh	r0, [r4, #14]
 80004b6:	89e3      	ldrh	r3, [r4, #14]
 80004b8:	8aa2      	ldrh	r2, [r4, #20]
 80004ba:	1a9b      	subs	r3, r3, r2
 80004bc:	b29b      	uxth	r3, r3
 80004be:	212c      	movs	r1, #44	; 0x2c
 80004c0:	20d4      	movs	r0, #212	; 0xd4
 80004c2:	8363      	strh	r3, [r4, #26]
 80004c4:	f002 faf7 	bl	8002ab6 <i2c_read_reg>
 80004c8:	212d      	movs	r1, #45	; 0x2d
 80004ca:	4605      	mov	r5, r0
 80004cc:	20d4      	movs	r0, #212	; 0xd4
 80004ce:	f002 faf2 	bl	8002ab6 <i2c_read_reg>
 80004d2:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 80004d6:	b280      	uxth	r0, r0
 80004d8:	8220      	strh	r0, [r4, #16]
 80004da:	8a23      	ldrh	r3, [r4, #16]
 80004dc:	8ae2      	ldrh	r2, [r4, #22]
 80004de:	1a9b      	subs	r3, r3, r2
 80004e0:	b29b      	uxth	r3, r3
 80004e2:	2108      	movs	r1, #8
 80004e4:	203c      	movs	r0, #60	; 0x3c
 80004e6:	83a3      	strh	r3, [r4, #28]
 80004e8:	f002 fae5 	bl	8002ab6 <i2c_read_reg>
 80004ec:	2109      	movs	r1, #9
 80004ee:	4605      	mov	r5, r0
 80004f0:	203c      	movs	r0, #60	; 0x3c
 80004f2:	f002 fae0 	bl	8002ab6 <i2c_read_reg>
 80004f6:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 80004fa:	b280      	uxth	r0, r0
 80004fc:	80e0      	strh	r0, [r4, #6]
 80004fe:	210a      	movs	r1, #10
 8000500:	203c      	movs	r0, #60	; 0x3c
 8000502:	f002 fad8 	bl	8002ab6 <i2c_read_reg>
 8000506:	210b      	movs	r1, #11
 8000508:	4605      	mov	r5, r0
 800050a:	203c      	movs	r0, #60	; 0x3c
 800050c:	f002 fad3 	bl	8002ab6 <i2c_read_reg>
 8000510:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000514:	b280      	uxth	r0, r0
 8000516:	8120      	strh	r0, [r4, #8]
 8000518:	210c      	movs	r1, #12
 800051a:	203c      	movs	r0, #60	; 0x3c
 800051c:	f002 facb 	bl	8002ab6 <i2c_read_reg>
 8000520:	210d      	movs	r1, #13
 8000522:	4605      	mov	r5, r0
 8000524:	203c      	movs	r0, #60	; 0x3c
 8000526:	f002 fac6 	bl	8002ab6 <i2c_read_reg>
 800052a:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 800052e:	b280      	uxth	r0, r0
 8000530:	8160      	strh	r0, [r4, #10]
 8000532:	2128      	movs	r1, #40	; 0x28
 8000534:	203c      	movs	r0, #60	; 0x3c
 8000536:	f002 fabe 	bl	8002ab6 <i2c_read_reg>
 800053a:	2129      	movs	r1, #41	; 0x29
 800053c:	4605      	mov	r5, r0
 800053e:	203c      	movs	r0, #60	; 0x3c
 8000540:	f002 fab9 	bl	8002ab6 <i2c_read_reg>
 8000544:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000548:	b280      	uxth	r0, r0
 800054a:	8020      	strh	r0, [r4, #0]
 800054c:	212a      	movs	r1, #42	; 0x2a
 800054e:	203c      	movs	r0, #60	; 0x3c
 8000550:	f002 fab1 	bl	8002ab6 <i2c_read_reg>
 8000554:	212b      	movs	r1, #43	; 0x2b
 8000556:	4605      	mov	r5, r0
 8000558:	203c      	movs	r0, #60	; 0x3c
 800055a:	f002 faac 	bl	8002ab6 <i2c_read_reg>
 800055e:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000562:	b280      	uxth	r0, r0
 8000564:	8060      	strh	r0, [r4, #2]
 8000566:	212c      	movs	r1, #44	; 0x2c
 8000568:	203c      	movs	r0, #60	; 0x3c
 800056a:	f002 faa4 	bl	8002ab6 <i2c_read_reg>
 800056e:	212d      	movs	r1, #45	; 0x2d
 8000570:	4605      	mov	r5, r0
 8000572:	203c      	movs	r0, #60	; 0x3c
 8000574:	f002 fa9f 	bl	8002ab6 <i2c_read_reg>
 8000578:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 800057c:	b280      	uxth	r0, r0
 800057e:	80a0      	strh	r0, [r4, #4]
 8000580:	2105      	movs	r1, #5
 8000582:	203c      	movs	r0, #60	; 0x3c
 8000584:	f002 fa97 	bl	8002ab6 <i2c_read_reg>
 8000588:	2106      	movs	r1, #6
 800058a:	4605      	mov	r5, r0
 800058c:	203c      	movs	r0, #60	; 0x3c
 800058e:	f002 fa92 	bl	8002ab6 <i2c_read_reg>
 8000592:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000596:	b280      	uxth	r0, r0
 8000598:	85a0      	strh	r0, [r4, #44]	; 0x2c
 800059a:	bd38      	pop	{r3, r4, r5, pc}
 800059c:	20000034 	.word	0x20000034

080005a0 <lsm9ds0_calibrate>:
 80005a0:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
 80005a4:	2400      	movs	r4, #0
 80005a6:	4681      	mov	r9, r0
 80005a8:	4625      	mov	r5, r4
 80005aa:	4626      	mov	r6, r4
 80005ac:	46a0      	mov	r8, r4
 80005ae:	45c8      	cmp	r8, r9
 80005b0:	4f10      	ldr	r7, [pc, #64]	; (80005f4 <lsm9ds0_calibrate+0x54>)
 80005b2:	d010      	beq.n	80005d6 <lsm9ds0_calibrate+0x36>
 80005b4:	f7ff ff5e 	bl	8000474 <lsm9ds0_read>
 80005b8:	89bb      	ldrh	r3, [r7, #12]
 80005ba:	fa06 f683 	sxtah	r6, r6, r3
 80005be:	89fb      	ldrh	r3, [r7, #14]
 80005c0:	fa05 f583 	sxtah	r5, r5, r3
 80005c4:	8a3b      	ldrh	r3, [r7, #16]
 80005c6:	200a      	movs	r0, #10
 80005c8:	fa04 f483 	sxtah	r4, r4, r3
 80005cc:	f108 0801 	add.w	r8, r8, #1
 80005d0:	f001 fb48 	bl	8001c64 <timer_delay_ms>
 80005d4:	e7eb      	b.n	80005ae <lsm9ds0_calibrate+0xe>
 80005d6:	fb96 f6f8 	sdiv	r6, r6, r8
 80005da:	fb95 f5f8 	sdiv	r5, r5, r8
 80005de:	b2b6      	uxth	r6, r6
 80005e0:	b2ad      	uxth	r5, r5
 80005e2:	fb94 f4f8 	sdiv	r4, r4, r8
 80005e6:	b2a4      	uxth	r4, r4
 80005e8:	827e      	strh	r6, [r7, #18]
 80005ea:	82bd      	strh	r5, [r7, #20]
 80005ec:	82fc      	strh	r4, [r7, #22]
 80005ee:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 80005f2:	bf00      	nop
 80005f4:	20000034 	.word	0x20000034

080005f8 <lsm9ds0_init>:
 80005f8:	4b29      	ldr	r3, [pc, #164]	; (80006a0 <lsm9ds0_init+0xa8>)
 80005fa:	b570      	push	{r4, r5, r6, lr}
 80005fc:	210f      	movs	r1, #15
 80005fe:	2400      	movs	r4, #0
 8000600:	4606      	mov	r6, r0
 8000602:	20d4      	movs	r0, #212	; 0xd4
 8000604:	801c      	strh	r4, [r3, #0]
 8000606:	805c      	strh	r4, [r3, #2]
 8000608:	809c      	strh	r4, [r3, #4]
 800060a:	80dc      	strh	r4, [r3, #6]
 800060c:	811c      	strh	r4, [r3, #8]
 800060e:	815c      	strh	r4, [r3, #10]
 8000610:	819c      	strh	r4, [r3, #12]
 8000612:	81dc      	strh	r4, [r3, #14]
 8000614:	821c      	strh	r4, [r3, #16]
 8000616:	831c      	strh	r4, [r3, #24]
 8000618:	835c      	strh	r4, [r3, #26]
 800061a:	839c      	strh	r4, [r3, #28]
 800061c:	859c      	strh	r4, [r3, #44]	; 0x2c
 800061e:	f002 fa4a 	bl	8002ab6 <i2c_read_reg>
 8000622:	28d4      	cmp	r0, #212	; 0xd4
 8000624:	4605      	mov	r5, r0
 8000626:	d137      	bne.n	8000698 <lsm9ds0_init+0xa0>
 8000628:	203c      	movs	r0, #60	; 0x3c
 800062a:	210f      	movs	r1, #15
 800062c:	f002 fa43 	bl	8002ab6 <i2c_read_reg>
 8000630:	2849      	cmp	r0, #73	; 0x49
 8000632:	d133      	bne.n	800069c <lsm9ds0_init+0xa4>
 8000634:	4628      	mov	r0, r5
 8000636:	2120      	movs	r1, #32
 8000638:	22ff      	movs	r2, #255	; 0xff
 800063a:	f002 fa29 	bl	8002a90 <i2c_write_reg>
 800063e:	4628      	mov	r0, r5
 8000640:	2123      	movs	r1, #35	; 0x23
 8000642:	2218      	movs	r2, #24
 8000644:	f002 fa24 	bl	8002a90 <i2c_write_reg>
 8000648:	203c      	movs	r0, #60	; 0x3c
 800064a:	211f      	movs	r1, #31
 800064c:	4622      	mov	r2, r4
 800064e:	f002 fa1f 	bl	8002a90 <i2c_write_reg>
 8000652:	203c      	movs	r0, #60	; 0x3c
 8000654:	2120      	movs	r1, #32
 8000656:	2267      	movs	r2, #103	; 0x67
 8000658:	f002 fa1a 	bl	8002a90 <i2c_write_reg>
 800065c:	203c      	movs	r0, #60	; 0x3c
 800065e:	2121      	movs	r1, #33	; 0x21
 8000660:	4622      	mov	r2, r4
 8000662:	f002 fa15 	bl	8002a90 <i2c_write_reg>
 8000666:	203c      	movs	r0, #60	; 0x3c
 8000668:	2124      	movs	r1, #36	; 0x24
 800066a:	22f4      	movs	r2, #244	; 0xf4
 800066c:	f002 fa10 	bl	8002a90 <i2c_write_reg>
 8000670:	203c      	movs	r0, #60	; 0x3c
 8000672:	2125      	movs	r1, #37	; 0x25
 8000674:	4622      	mov	r2, r4
 8000676:	f002 fa0b 	bl	8002a90 <i2c_write_reg>
 800067a:	203c      	movs	r0, #60	; 0x3c
 800067c:	2126      	movs	r1, #38	; 0x26
 800067e:	2280      	movs	r2, #128	; 0x80
 8000680:	f002 fa06 	bl	8002a90 <i2c_write_reg>
 8000684:	f7ff fef6 	bl	8000474 <lsm9ds0_read>
 8000688:	b116      	cbz	r6, 8000690 <lsm9ds0_init+0x98>
 800068a:	2064      	movs	r0, #100	; 0x64
 800068c:	f7ff ff88 	bl	80005a0 <lsm9ds0_calibrate>
 8000690:	f7ff fef0 	bl	8000474 <lsm9ds0_read>
 8000694:	2000      	movs	r0, #0
 8000696:	bd70      	pop	{r4, r5, r6, pc}
 8000698:	2001      	movs	r0, #1
 800069a:	bd70      	pop	{r4, r5, r6, pc}
 800069c:	2002      	movs	r0, #2
 800069e:	bd70      	pop	{r4, r5, r6, pc}
 80006a0:	20000034 	.word	0x20000034

080006a4 <rgb_sensor_uninit>:
 80006a4:	b508      	push	{r3, lr}
 80006a6:	2008      	movs	r0, #8
 80006a8:	f002 f824 	bl	80026f4 <led_off>
 80006ac:	2072      	movs	r0, #114	; 0x72
 80006ae:	2180      	movs	r1, #128	; 0x80
 80006b0:	2200      	movs	r2, #0
 80006b2:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80006b6:	f7ff be9d 	b.w	80003f4 <rgb_i2c_write_reg>
	...

080006bc <rgb_sensor_read>:
 80006bc:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 80006be:	f7ff fe19 	bl	80002f4 <rgb_i2cStart>
 80006c2:	2072      	movs	r0, #114	; 0x72
 80006c4:	4d70      	ldr	r5, [pc, #448]	; (8000888 <rgb_sensor_read+0x1cc>)
 80006c6:	4c71      	ldr	r4, [pc, #452]	; (800088c <rgb_sensor_read+0x1d0>)
 80006c8:	f7ff fe32 	bl	8000330 <rgb_i2cWrite>
 80006cc:	20b4      	movs	r0, #180	; 0xb4
 80006ce:	f7ff fe2f 	bl	8000330 <rgb_i2cWrite>
 80006d2:	f7ff fe0f 	bl	80002f4 <rgb_i2cStart>
 80006d6:	2073      	movs	r0, #115	; 0x73
 80006d8:	f7ff fe2a 	bl	8000330 <rgb_i2cWrite>
 80006dc:	2001      	movs	r0, #1
 80006de:	4629      	mov	r1, r5
 80006e0:	f7ff fe46 	bl	8000370 <rgb_i2cRead>
 80006e4:	782b      	ldrb	r3, [r5, #0]
 80006e6:	8323      	strh	r3, [r4, #24]
 80006e8:	786b      	ldrb	r3, [r5, #1]
 80006ea:	8363      	strh	r3, [r4, #26]
 80006ec:	78ab      	ldrb	r3, [r5, #2]
 80006ee:	83a3      	strh	r3, [r4, #28]
 80006f0:	2001      	movs	r0, #1
 80006f2:	78eb      	ldrb	r3, [r5, #3]
 80006f4:	83e3      	strh	r3, [r4, #30]
 80006f6:	4629      	mov	r1, r5
 80006f8:	f7ff fe3a 	bl	8000370 <rgb_i2cRead>
 80006fc:	2300      	movs	r3, #0
 80006fe:	f103 010c 	add.w	r1, r3, #12
 8000702:	5ce8      	ldrb	r0, [r5, r3]
 8000704:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 8000708:	4f60      	ldr	r7, [pc, #384]	; (800088c <rgb_sensor_read+0x1d0>)
 800070a:	4e5f      	ldr	r6, [pc, #380]	; (8000888 <rgb_sensor_read+0x1cc>)
 800070c:	b292      	uxth	r2, r2
 800070e:	3301      	adds	r3, #1
 8000710:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 8000714:	2b04      	cmp	r3, #4
 8000716:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 800071a:	d1f0      	bne.n	80006fe <rgb_sensor_read+0x42>
 800071c:	2001      	movs	r0, #1
 800071e:	4631      	mov	r1, r6
 8000720:	f7ff fe26 	bl	8000370 <rgb_i2cRead>
 8000724:	7833      	ldrb	r3, [r6, #0]
 8000726:	803b      	strh	r3, [r7, #0]
 8000728:	7873      	ldrb	r3, [r6, #1]
 800072a:	807b      	strh	r3, [r7, #2]
 800072c:	78b3      	ldrb	r3, [r6, #2]
 800072e:	80bb      	strh	r3, [r7, #4]
 8000730:	2001      	movs	r0, #1
 8000732:	78f3      	ldrb	r3, [r6, #3]
 8000734:	80fb      	strh	r3, [r7, #6]
 8000736:	4631      	mov	r1, r6
 8000738:	f7ff fe1a 	bl	8000370 <rgb_i2cRead>
 800073c:	2300      	movs	r3, #0
 800073e:	f834 2013 	ldrh.w	r2, [r4, r3, lsl #1]
 8000742:	5ce9      	ldrb	r1, [r5, r3]
 8000744:	4f51      	ldr	r7, [pc, #324]	; (800088c <rgb_sensor_read+0x1d0>)
 8000746:	4e50      	ldr	r6, [pc, #320]	; (8000888 <rgb_sensor_read+0x1cc>)
 8000748:	b292      	uxth	r2, r2
 800074a:	ea42 2201 	orr.w	r2, r2, r1, lsl #8
 800074e:	f824 2013 	strh.w	r2, [r4, r3, lsl #1]
 8000752:	3301      	adds	r3, #1
 8000754:	2b04      	cmp	r3, #4
 8000756:	d1f2      	bne.n	800073e <rgb_sensor_read+0x82>
 8000758:	2001      	movs	r0, #1
 800075a:	4631      	mov	r1, r6
 800075c:	f7ff fe08 	bl	8000370 <rgb_i2cRead>
 8000760:	7833      	ldrb	r3, [r6, #0]
 8000762:	813b      	strh	r3, [r7, #8]
 8000764:	7873      	ldrb	r3, [r6, #1]
 8000766:	817b      	strh	r3, [r7, #10]
 8000768:	78b3      	ldrb	r3, [r6, #2]
 800076a:	81bb      	strh	r3, [r7, #12]
 800076c:	2001      	movs	r0, #1
 800076e:	78f3      	ldrb	r3, [r6, #3]
 8000770:	81fb      	strh	r3, [r7, #14]
 8000772:	4631      	mov	r1, r6
 8000774:	f7ff fdfc 	bl	8000370 <rgb_i2cRead>
 8000778:	2300      	movs	r3, #0
 800077a:	1d19      	adds	r1, r3, #4
 800077c:	5ce8      	ldrb	r0, [r5, r3]
 800077e:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 8000782:	4f42      	ldr	r7, [pc, #264]	; (800088c <rgb_sensor_read+0x1d0>)
 8000784:	4e40      	ldr	r6, [pc, #256]	; (8000888 <rgb_sensor_read+0x1cc>)
 8000786:	b292      	uxth	r2, r2
 8000788:	3301      	adds	r3, #1
 800078a:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 800078e:	2b04      	cmp	r3, #4
 8000790:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 8000794:	d1f1      	bne.n	800077a <rgb_sensor_read+0xbe>
 8000796:	2001      	movs	r0, #1
 8000798:	4631      	mov	r1, r6
 800079a:	f7ff fde9 	bl	8000370 <rgb_i2cRead>
 800079e:	7833      	ldrb	r3, [r6, #0]
 80007a0:	823b      	strh	r3, [r7, #16]
 80007a2:	7873      	ldrb	r3, [r6, #1]
 80007a4:	827b      	strh	r3, [r7, #18]
 80007a6:	78b3      	ldrb	r3, [r6, #2]
 80007a8:	82bb      	strh	r3, [r7, #20]
 80007aa:	2001      	movs	r0, #1
 80007ac:	78f3      	ldrb	r3, [r6, #3]
 80007ae:	82fb      	strh	r3, [r7, #22]
 80007b0:	4631      	mov	r1, r6
 80007b2:	f7ff fddd 	bl	8000370 <rgb_i2cRead>
 80007b6:	2300      	movs	r3, #0
 80007b8:	f103 0108 	add.w	r1, r3, #8
 80007bc:	5ce8      	ldrb	r0, [r5, r3]
 80007be:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 80007c2:	4f32      	ldr	r7, [pc, #200]	; (800088c <rgb_sensor_read+0x1d0>)
 80007c4:	4e30      	ldr	r6, [pc, #192]	; (8000888 <rgb_sensor_read+0x1cc>)
 80007c6:	b292      	uxth	r2, r2
 80007c8:	3301      	adds	r3, #1
 80007ca:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 80007ce:	2b04      	cmp	r3, #4
 80007d0:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 80007d4:	d1f0      	bne.n	80007b8 <rgb_sensor_read+0xfc>
 80007d6:	2001      	movs	r0, #1
 80007d8:	4631      	mov	r1, r6
 80007da:	f7ff fdc9 	bl	8000370 <rgb_i2cRead>
 80007de:	7833      	ldrb	r3, [r6, #0]
 80007e0:	843b      	strh	r3, [r7, #32]
 80007e2:	7873      	ldrb	r3, [r6, #1]
 80007e4:	847b      	strh	r3, [r7, #34]	; 0x22
 80007e6:	78b3      	ldrb	r3, [r6, #2]
 80007e8:	84bb      	strh	r3, [r7, #36]	; 0x24
 80007ea:	2000      	movs	r0, #0
 80007ec:	78f3      	ldrb	r3, [r6, #3]
 80007ee:	84fb      	strh	r3, [r7, #38]	; 0x26
 80007f0:	4631      	mov	r1, r6
 80007f2:	f7ff fdbd 	bl	8000370 <rgb_i2cRead>
 80007f6:	2300      	movs	r3, #0
 80007f8:	f103 0110 	add.w	r1, r3, #16
 80007fc:	5ce8      	ldrb	r0, [r5, r3]
 80007fe:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 8000802:	3301      	adds	r3, #1
 8000804:	b292      	uxth	r2, r2
 8000806:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 800080a:	2b04      	cmp	r3, #4
 800080c:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 8000810:	d1f2      	bne.n	80007f8 <rgb_sensor_read+0x13c>
 8000812:	f7ff fd7e 	bl	8000312 <rgb_i2cStop>
 8000816:	2300      	movs	r3, #0
 8000818:	1d1e      	adds	r6, r3, #4
 800081a:	f834 1013 	ldrh.w	r1, [r4, r3, lsl #1]
 800081e:	f834 2016 	ldrh.w	r2, [r4, r6, lsl #1]
 8000822:	f103 0508 	add.w	r5, r3, #8
 8000826:	b212      	sxth	r2, r2
 8000828:	f834 0015 	ldrh.w	r0, [r4, r5, lsl #1]
 800082c:	fa02 f281 	sxtah	r2, r2, r1
 8000830:	f834 1013 	ldrh.w	r1, [r4, r3, lsl #1]
 8000834:	fa02 f080 	sxtah	r0, r2, r0
 8000838:	f103 0734 	add.w	r7, r3, #52	; 0x34
 800083c:	2264      	movs	r2, #100	; 0x64
 800083e:	b289      	uxth	r1, r1
 8000840:	fb11 f102 	smulbb	r1, r1, r2
 8000844:	fb91 f1f0 	sdiv	r1, r1, r0
 8000848:	b289      	uxth	r1, r1
 800084a:	f824 1017 	strh.w	r1, [r4, r7, lsl #1]
 800084e:	f834 1016 	ldrh.w	r1, [r4, r6, lsl #1]
 8000852:	f103 0638 	add.w	r6, r3, #56	; 0x38
 8000856:	b289      	uxth	r1, r1
 8000858:	fb11 f102 	smulbb	r1, r1, r2
 800085c:	fb91 f1f0 	sdiv	r1, r1, r0
 8000860:	b289      	uxth	r1, r1
 8000862:	f824 1016 	strh.w	r1, [r4, r6, lsl #1]
 8000866:	f834 1015 	ldrh.w	r1, [r4, r5, lsl #1]
 800086a:	b289      	uxth	r1, r1
 800086c:	fb11 f202 	smulbb	r2, r1, r2
 8000870:	f103 013c 	add.w	r1, r3, #60	; 0x3c
 8000874:	3301      	adds	r3, #1
 8000876:	fb92 f2f0 	sdiv	r2, r2, r0
 800087a:	2b04      	cmp	r3, #4
 800087c:	b292      	uxth	r2, r2
 800087e:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 8000882:	d1c9      	bne.n	8000818 <rgb_sensor_read+0x15c>
 8000884:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
 8000886:	bf00      	nop
 8000888:	20000100 	.word	0x20000100
 800088c:	20000064 	.word	0x20000064

08000890 <rgb_sensor_init>:
 8000890:	b537      	push	{r0, r1, r2, r4, r5, lr}
 8000892:	2300      	movs	r3, #0
 8000894:	4a29      	ldr	r2, [pc, #164]	; (800093c <rgb_sensor_init+0xac>)
 8000896:	1d19      	adds	r1, r3, #4
 8000898:	2400      	movs	r4, #0
 800089a:	f822 4013 	strh.w	r4, [r2, r3, lsl #1]
 800089e:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008a2:	f103 0108 	add.w	r1, r3, #8
 80008a6:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008aa:	f103 0110 	add.w	r1, r3, #16
 80008ae:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008b2:	f103 010c 	add.w	r1, r3, #12
 80008b6:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008ba:	f103 0134 	add.w	r1, r3, #52	; 0x34
 80008be:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008c2:	f103 0138 	add.w	r1, r3, #56	; 0x38
 80008c6:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008ca:	f103 013c 	add.w	r1, r3, #60	; 0x3c
 80008ce:	3301      	adds	r3, #1
 80008d0:	2b04      	cmp	r3, #4
 80008d2:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 80008d6:	d1dd      	bne.n	8000894 <rgb_sensor_init+0x4>
 80008d8:	f7ff fcdc 	bl	8000294 <rgb_i2c_init>
 80008dc:	2072      	movs	r0, #114	; 0x72
 80008de:	2181      	movs	r1, #129	; 0x81
 80008e0:	22ff      	movs	r2, #255	; 0xff
 80008e2:	f7ff fd87 	bl	80003f4 <rgb_i2c_write_reg>
 80008e6:	2072      	movs	r0, #114	; 0x72
 80008e8:	2183      	movs	r1, #131	; 0x83
 80008ea:	22ff      	movs	r2, #255	; 0xff
 80008ec:	f7ff fd82 	bl	80003f4 <rgb_i2c_write_reg>
 80008f0:	2072      	movs	r0, #114	; 0x72
 80008f2:	218d      	movs	r1, #141	; 0x8d
 80008f4:	4622      	mov	r2, r4
 80008f6:	f7ff fd7d 	bl	80003f4 <rgb_i2c_write_reg>
 80008fa:	2072      	movs	r0, #114	; 0x72
 80008fc:	2180      	movs	r1, #128	; 0x80
 80008fe:	2203      	movs	r2, #3
 8000900:	f7ff fd78 	bl	80003f4 <rgb_i2c_write_reg>
 8000904:	ad01      	add	r5, sp, #4
 8000906:	2072      	movs	r0, #114	; 0x72
 8000908:	218f      	movs	r1, #143	; 0x8f
 800090a:	2223      	movs	r2, #35	; 0x23
 800090c:	f7ff fd72 	bl	80003f4 <rgb_i2c_write_reg>
 8000910:	f7ff fed4 	bl	80006bc <rgb_sensor_read>
 8000914:	2072      	movs	r0, #114	; 0x72
 8000916:	2192      	movs	r1, #146	; 0x92
 8000918:	462a      	mov	r2, r5
 800091a:	f7ff fd7e 	bl	800041a <rgb_i2c_read_reg>
 800091e:	4620      	mov	r0, r4
 8000920:	4623      	mov	r3, r4
 8000922:	5cea      	ldrb	r2, [r5, r3]
 8000924:	2a69      	cmp	r2, #105	; 0x69
 8000926:	bf1c      	itt	ne
 8000928:	2201      	movne	r2, #1
 800092a:	409a      	lslne	r2, r3
 800092c:	f103 0301 	add.w	r3, r3, #1
 8000930:	bf18      	it	ne
 8000932:	4310      	orrne	r0, r2
 8000934:	2b04      	cmp	r3, #4
 8000936:	d1f4      	bne.n	8000922 <rgb_sensor_init+0x92>
 8000938:	b003      	add	sp, #12
 800093a:	bd30      	pop	{r4, r5, pc}
 800093c:	20000064 	.word	0x20000064

08000940 <rgb_get_line_position>:
 8000940:	4b54      	ldr	r3, [pc, #336]	; (8000a94 <rgb_get_line_position+0x154>)
 8000942:	b5f0      	push	{r4, r5, r6, r7, lr}
 8000944:	cb0f      	ldmia	r3, {r0, r1, r2, r3}
 8000946:	b085      	sub	sp, #20
 8000948:	e88d 000f 	stmia.w	sp, {r0, r1, r2, r3}
 800094c:	2200      	movs	r2, #0
 800094e:	466c      	mov	r4, sp
 8000950:	4615      	mov	r5, r2
 8000952:	4611      	mov	r1, r2
 8000954:	4b50      	ldr	r3, [pc, #320]	; (8000a98 <rgb_get_line_position+0x158>)
 8000956:	f101 0e0c 	add.w	lr, r1, #12
 800095a:	f101 060a 	add.w	r6, r1, #10
 800095e:	f833 001e 	ldrh.w	r0, [r3, lr, lsl #1]
 8000962:	f853 7026 	ldr.w	r7, [r3, r6, lsl #2]
 8000966:	b200      	sxth	r0, r0
 8000968:	1bc0      	subs	r0, r0, r7
 800096a:	f854 7021 	ldr.w	r7, [r4, r1, lsl #2]
 800096e:	fb07 2200 	mla	r2, r7, r0, r2
 8000972:	f833 001e 	ldrh.w	r0, [r3, lr, lsl #1]
 8000976:	f853 6026 	ldr.w	r6, [r3, r6, lsl #2]
 800097a:	b200      	sxth	r0, r0
 800097c:	3101      	adds	r1, #1
 800097e:	1b80      	subs	r0, r0, r6
 8000980:	2904      	cmp	r1, #4
 8000982:	4405      	add	r5, r0
 8000984:	d1e6      	bne.n	8000954 <rgb_get_line_position+0x14>
 8000986:	4945      	ldr	r1, [pc, #276]	; (8000a9c <rgb_get_line_position+0x15c>)
 8000988:	f5b5 7f7a 	cmp.w	r5, #1000	; 0x3e8
 800098c:	f04f 0000 	mov.w	r0, #0
 8000990:	7408      	strb	r0, [r1, #16]
 8000992:	bfc1      	itttt	gt
 8000994:	fb92 f2f5 	sdivgt	r2, r2, r5
 8000998:	2001      	movgt	r0, #1
 800099a:	3a47      	subgt	r2, #71	; 0x47
 800099c:	7408      	strbgt	r0, [r1, #16]
 800099e:	bfc8      	it	gt
 80009a0:	600a      	strgt	r2, [r1, #0]
 80009a2:	2200      	movs	r2, #0
 80009a4:	4616      	mov	r6, r2
 80009a6:	4610      	mov	r0, r2
 80009a8:	f100 0e0e 	add.w	lr, r0, #14
 80009ac:	f833 5010 	ldrh.w	r5, [r3, r0, lsl #1]
 80009b0:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 80009b4:	b22d      	sxth	r5, r5
 80009b6:	1bed      	subs	r5, r5, r7
 80009b8:	f854 7020 	ldr.w	r7, [r4, r0, lsl #2]
 80009bc:	fb07 2205 	mla	r2, r7, r5, r2
 80009c0:	f833 5010 	ldrh.w	r5, [r3, r0, lsl #1]
 80009c4:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 80009c8:	b22d      	sxth	r5, r5
 80009ca:	3001      	adds	r0, #1
 80009cc:	1bed      	subs	r5, r5, r7
 80009ce:	2804      	cmp	r0, #4
 80009d0:	442e      	add	r6, r5
 80009d2:	d1e9      	bne.n	80009a8 <rgb_get_line_position+0x68>
 80009d4:	2e28      	cmp	r6, #40	; 0x28
 80009d6:	4831      	ldr	r0, [pc, #196]	; (8000a9c <rgb_get_line_position+0x15c>)
 80009d8:	bfc8      	it	gt
 80009da:	fb92 f2f6 	sdivgt	r2, r2, r6
 80009de:	f04f 0500 	mov.w	r5, #0
 80009e2:	744d      	strb	r5, [r1, #17]
 80009e4:	bfc1      	itttt	gt
 80009e6:	3a47      	subgt	r2, #71	; 0x47
 80009e8:	2501      	movgt	r5, #1
 80009ea:	7445      	strbgt	r5, [r0, #17]
 80009ec:	6042      	strgt	r2, [r0, #4]
 80009ee:	2200      	movs	r2, #0
 80009f0:	4616      	mov	r6, r2
 80009f2:	4610      	mov	r0, r2
 80009f4:	f100 0c04 	add.w	ip, r0, #4
 80009f8:	f100 0e12 	add.w	lr, r0, #18
 80009fc:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 8000a00:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8000a04:	b22d      	sxth	r5, r5
 8000a06:	1bed      	subs	r5, r5, r7
 8000a08:	f854 7020 	ldr.w	r7, [r4, r0, lsl #2]
 8000a0c:	fb07 2205 	mla	r2, r7, r5, r2
 8000a10:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 8000a14:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8000a18:	b22d      	sxth	r5, r5
 8000a1a:	3001      	adds	r0, #1
 8000a1c:	1bed      	subs	r5, r5, r7
 8000a1e:	2804      	cmp	r0, #4
 8000a20:	442e      	add	r6, r5
 8000a22:	d1e7      	bne.n	80009f4 <rgb_get_line_position+0xb4>
 8000a24:	2e0a      	cmp	r6, #10
 8000a26:	481d      	ldr	r0, [pc, #116]	; (8000a9c <rgb_get_line_position+0x15c>)
 8000a28:	bfc8      	it	gt
 8000a2a:	fb92 f2f6 	sdivgt	r2, r2, r6
 8000a2e:	f04f 0500 	mov.w	r5, #0
 8000a32:	748d      	strb	r5, [r1, #18]
 8000a34:	bfc1      	itttt	gt
 8000a36:	3a47      	subgt	r2, #71	; 0x47
 8000a38:	2501      	movgt	r5, #1
 8000a3a:	7485      	strbgt	r5, [r0, #18]
 8000a3c:	6082      	strgt	r2, [r0, #8]
 8000a3e:	2200      	movs	r2, #0
 8000a40:	4616      	mov	r6, r2
 8000a42:	4610      	mov	r0, r2
 8000a44:	f100 0c08 	add.w	ip, r0, #8
 8000a48:	f100 0e16 	add.w	lr, r0, #22
 8000a4c:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 8000a50:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8000a54:	b22d      	sxth	r5, r5
 8000a56:	1bed      	subs	r5, r5, r7
 8000a58:	f854 7020 	ldr.w	r7, [r4, r0, lsl #2]
 8000a5c:	fb07 2205 	mla	r2, r7, r5, r2
 8000a60:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 8000a64:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8000a68:	b22d      	sxth	r5, r5
 8000a6a:	3001      	adds	r0, #1
 8000a6c:	1bed      	subs	r5, r5, r7
 8000a6e:	2804      	cmp	r0, #4
 8000a70:	442e      	add	r6, r5
 8000a72:	d1e7      	bne.n	8000a44 <rgb_get_line_position+0x104>
 8000a74:	2e0a      	cmp	r6, #10
 8000a76:	4b09      	ldr	r3, [pc, #36]	; (8000a9c <rgb_get_line_position+0x15c>)
 8000a78:	bfc8      	it	gt
 8000a7a:	fb92 f2f6 	sdivgt	r2, r2, r6
 8000a7e:	f04f 0000 	mov.w	r0, #0
 8000a82:	74c8      	strb	r0, [r1, #19]
 8000a84:	bfc1      	itttt	gt
 8000a86:	3a47      	subgt	r2, #71	; 0x47
 8000a88:	2101      	movgt	r1, #1
 8000a8a:	74d9      	strbgt	r1, [r3, #19]
 8000a8c:	60da      	strgt	r2, [r3, #12]
 8000a8e:	b005      	add	sp, #20
 8000a90:	bdf0      	pop	{r4, r5, r6, r7, pc}
 8000a92:	bf00      	nop
 8000a94:	08002b18 	.word	0x08002b18
 8000a98:	20000064 	.word	0x20000064
 8000a9c:	200000ec 	.word	0x200000ec

08000aa0 <rgb_set_background>:
 8000aa0:	b530      	push	{r4, r5, lr}
 8000aa2:	2200      	movs	r2, #0
 8000aa4:	4b36      	ldr	r3, [pc, #216]	; (8000b80 <rgb_set_background+0xe0>)
 8000aa6:	f102 000a 	add.w	r0, r2, #10
 8000aaa:	2100      	movs	r1, #0
 8000aac:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 8000ab0:	f102 000e 	add.w	r0, r2, #14
 8000ab4:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 8000ab8:	f102 0016 	add.w	r0, r2, #22
 8000abc:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 8000ac0:	f102 0012 	add.w	r0, r2, #18
 8000ac4:	3201      	adds	r2, #1
 8000ac6:	2a04      	cmp	r2, #4
 8000ac8:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 8000acc:	d1ea      	bne.n	8000aa4 <rgb_set_background+0x4>
 8000ace:	2264      	movs	r2, #100	; 0x64
 8000ad0:	2100      	movs	r1, #0
 8000ad2:	f101 040a 	add.w	r4, r1, #10
 8000ad6:	f101 000c 	add.w	r0, r1, #12
 8000ada:	f833 0010 	ldrh.w	r0, [r3, r0, lsl #1]
 8000ade:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8000ae2:	fa05 f080 	sxtah	r0, r5, r0
 8000ae6:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000aea:	f101 040e 	add.w	r4, r1, #14
 8000aee:	f833 0011 	ldrh.w	r0, [r3, r1, lsl #1]
 8000af2:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8000af6:	fa05 f080 	sxtah	r0, r5, r0
 8000afa:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000afe:	f101 0416 	add.w	r4, r1, #22
 8000b02:	1d08      	adds	r0, r1, #4
 8000b04:	f833 0010 	ldrh.w	r0, [r3, r0, lsl #1]
 8000b08:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8000b0c:	fa05 f080 	sxtah	r0, r5, r0
 8000b10:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b14:	f101 0412 	add.w	r4, r1, #18
 8000b18:	f101 0008 	add.w	r0, r1, #8
 8000b1c:	3101      	adds	r1, #1
 8000b1e:	f833 0010 	ldrh.w	r0, [r3, r0, lsl #1]
 8000b22:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8000b26:	2904      	cmp	r1, #4
 8000b28:	fa05 f080 	sxtah	r0, r5, r0
 8000b2c:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b30:	d1cf      	bne.n	8000ad2 <rgb_set_background+0x32>
 8000b32:	3a01      	subs	r2, #1
 8000b34:	d1cc      	bne.n	8000ad0 <rgb_set_background+0x30>
 8000b36:	f102 040a 	add.w	r4, r2, #10
 8000b3a:	2164      	movs	r1, #100	; 0x64
 8000b3c:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 8000b40:	fb90 f0f1 	sdiv	r0, r0, r1
 8000b44:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b48:	f102 040e 	add.w	r4, r2, #14
 8000b4c:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 8000b50:	fb90 f0f1 	sdiv	r0, r0, r1
 8000b54:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b58:	f102 0416 	add.w	r4, r2, #22
 8000b5c:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 8000b60:	fb90 f0f1 	sdiv	r0, r0, r1
 8000b64:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8000b68:	f102 0412 	add.w	r4, r2, #18
 8000b6c:	3201      	adds	r2, #1
 8000b6e:	2a04      	cmp	r2, #4
 8000b70:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 8000b74:	fb90 f1f1 	sdiv	r1, r0, r1
 8000b78:	f843 1024 	str.w	r1, [r3, r4, lsl #2]
 8000b7c:	d1db      	bne.n	8000b36 <rgb_set_background+0x96>
 8000b7e:	bd30      	pop	{r4, r5, pc}
 8000b80:	20000064 	.word	0x20000064

08000b84 <esp8266_send>:
 8000b84:	b510      	push	{r4, lr}
 8000b86:	1e44      	subs	r4, r0, #1
 8000b88:	f814 0f01 	ldrb.w	r0, [r4, #1]!
 8000b8c:	b110      	cbz	r0, 8000b94 <esp8266_send+0x10>
 8000b8e:	f001 fc01 	bl	8002394 <uart_write>
 8000b92:	e7f9      	b.n	8000b88 <esp8266_send+0x4>
 8000b94:	bd10      	pop	{r4, pc}

08000b96 <esp8266_send_uint>:
 8000b96:	b51f      	push	{r0, r1, r2, r3, r4, lr}
 8000b98:	2300      	movs	r3, #0
 8000b9a:	f88d 300f 	strb.w	r3, [sp, #15]
 8000b9e:	220a      	movs	r2, #10
 8000ba0:	230a      	movs	r3, #10
 8000ba2:	a901      	add	r1, sp, #4
 8000ba4:	fbb0 f4f3 	udiv	r4, r0, r3
 8000ba8:	fb03 0314 	mls	r3, r3, r4, r0
 8000bac:	3330      	adds	r3, #48	; 0x30
 8000bae:	5453      	strb	r3, [r2, r1]
 8000bb0:	4620      	mov	r0, r4
 8000bb2:	1e53      	subs	r3, r2, #1
 8000bb4:	b10c      	cbz	r4, 8000bba <esp8266_send_uint+0x24>
 8000bb6:	461a      	mov	r2, r3
 8000bb8:	e7f2      	b.n	8000ba0 <esp8266_send_uint+0xa>
 8000bba:	1888      	adds	r0, r1, r2
 8000bbc:	f7ff ffe2 	bl	8000b84 <esp8266_send>
 8000bc0:	b004      	add	sp, #16
 8000bc2:	bd10      	pop	{r4, pc}

08000bc4 <esp8266_find_stream>:
 8000bc4:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000bc6:	4615      	mov	r5, r2
 8000bc8:	460f      	mov	r7, r1
 8000bca:	4606      	mov	r6, r0
 8000bcc:	f001 f83c 	bl	8001c48 <timer_get_time>
 8000bd0:	4405      	add	r5, r0
 8000bd2:	f001 fc99 	bl	8002508 <uart_clear_buffer>
 8000bd6:	2400      	movs	r4, #0
 8000bd8:	f001 fbe8 	bl	80023ac <uart_is_char>
 8000bdc:	f64f 73ff 	movw	r3, #65535	; 0xffff
 8000be0:	4298      	cmp	r0, r3
 8000be2:	d00c      	beq.n	8000bfe <esp8266_find_stream+0x3a>
 8000be4:	5d33      	ldrb	r3, [r6, r4]
 8000be6:	4283      	cmp	r3, r0
 8000be8:	d108      	bne.n	8000bfc <esp8266_find_stream+0x38>
 8000bea:	1e7b      	subs	r3, r7, #1
 8000bec:	429c      	cmp	r4, r3
 8000bee:	d201      	bcs.n	8000bf4 <esp8266_find_stream+0x30>
 8000bf0:	3401      	adds	r4, #1
 8000bf2:	e004      	b.n	8000bfe <esp8266_find_stream+0x3a>
 8000bf4:	f001 fc88 	bl	8002508 <uart_clear_buffer>
 8000bf8:	2001      	movs	r0, #1
 8000bfa:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
 8000bfc:	2400      	movs	r4, #0
 8000bfe:	f001 f823 	bl	8001c48 <timer_get_time>
 8000c02:	42a8      	cmp	r0, r5
 8000c04:	d3e8      	bcc.n	8000bd8 <esp8266_find_stream+0x14>
 8000c06:	f001 fc7f 	bl	8002508 <uart_clear_buffer>
 8000c0a:	2000      	movs	r0, #0
 8000c0c:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
	...

08000c10 <esp8266_init>:
 8000c10:	4b1d      	ldr	r3, [pc, #116]	; (8000c88 <esp8266_init+0x78>)
 8000c12:	b510      	push	{r4, lr}
 8000c14:	2200      	movs	r2, #0
 8000c16:	4604      	mov	r4, r0
 8000c18:	f640 30b8 	movw	r0, #3000	; 0xbb8
 8000c1c:	601a      	str	r2, [r3, #0]
 8000c1e:	f001 f821 	bl	8001c64 <timer_delay_ms>
 8000c22:	b10c      	cbz	r4, 8000c28 <esp8266_init+0x18>
 8000c24:	4819      	ldr	r0, [pc, #100]	; (8000c8c <esp8266_init+0x7c>)
 8000c26:	e000      	b.n	8000c2a <esp8266_init+0x1a>
 8000c28:	4819      	ldr	r0, [pc, #100]	; (8000c90 <esp8266_init+0x80>)
 8000c2a:	f7ff ffab 	bl	8000b84 <esp8266_send>
 8000c2e:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 8000c32:	f001 f817 	bl	8001c64 <timer_delay_ms>
 8000c36:	4817      	ldr	r0, [pc, #92]	; (8000c94 <esp8266_init+0x84>)
 8000c38:	f7ff ffa4 	bl	8000b84 <esp8266_send>
 8000c3c:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 8000c40:	f001 f810 	bl	8001c64 <timer_delay_ms>
 8000c44:	4814      	ldr	r0, [pc, #80]	; (8000c98 <esp8266_init+0x88>)
 8000c46:	f7ff ff9d 	bl	8000b84 <esp8266_send>
 8000c4a:	4814      	ldr	r0, [pc, #80]	; (8000c9c <esp8266_init+0x8c>)
 8000c4c:	f7ff ff9a 	bl	8000b84 <esp8266_send>
 8000c50:	4813      	ldr	r0, [pc, #76]	; (8000ca0 <esp8266_init+0x90>)
 8000c52:	f7ff ff97 	bl	8000b84 <esp8266_send>
 8000c56:	4813      	ldr	r0, [pc, #76]	; (8000ca4 <esp8266_init+0x94>)
 8000c58:	f7ff ff94 	bl	8000b84 <esp8266_send>
 8000c5c:	4812      	ldr	r0, [pc, #72]	; (8000ca8 <esp8266_init+0x98>)
 8000c5e:	f7ff ff91 	bl	8000b84 <esp8266_send>
 8000c62:	4812      	ldr	r0, [pc, #72]	; (8000cac <esp8266_init+0x9c>)
 8000c64:	2102      	movs	r1, #2
 8000c66:	f644 6220 	movw	r2, #20000	; 0x4e20
 8000c6a:	f7ff ffab 	bl	8000bc4 <esp8266_find_stream>
 8000c6e:	b140      	cbz	r0, 8000c82 <esp8266_init+0x72>
 8000c70:	b12c      	cbz	r4, 8000c7e <esp8266_init+0x6e>
 8000c72:	480f      	ldr	r0, [pc, #60]	; (8000cb0 <esp8266_init+0xa0>)
 8000c74:	f7ff ff86 	bl	8000b84 <esp8266_send>
 8000c78:	20c8      	movs	r0, #200	; 0xc8
 8000c7a:	f000 fff3 	bl	8001c64 <timer_delay_ms>
 8000c7e:	2000      	movs	r0, #0
 8000c80:	bd10      	pop	{r4, pc}
 8000c82:	f06f 0001 	mvn.w	r0, #1
 8000c86:	bd10      	pop	{r4, pc}
 8000c88:	20000204 	.word	0x20000204
 8000c8c:	08002b28 	.word	0x08002b28
 8000c90:	08002b36 	.word	0x08002b36
 8000c94:	08002b44 	.word	0x08002b44
 8000c98:	08002b52 	.word	0x08002b52
 8000c9c:	08002b5d 	.word	0x08002b5d
 8000ca0:	08002ba2 	.word	0x08002ba2
 8000ca4:	08002b63 	.word	0x08002b63
 8000ca8:	08002b6c 	.word	0x08002b6c
 8000cac:	08002bc4 	.word	0x08002bc4
 8000cb0:	08002b70 	.word	0x08002b70

08000cb4 <esp8266_uninit>:
 8000cb4:	4770      	bx	lr

08000cb6 <esp8266_get_nonblocking>:
 8000cb6:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000cb8:	4615      	mov	r5, r2
 8000cba:	4606      	mov	r6, r0
 8000cbc:	460f      	mov	r7, r1
 8000cbe:	4603      	mov	r3, r0
 8000cc0:	1842      	adds	r2, r0, r1
 8000cc2:	4293      	cmp	r3, r2
 8000cc4:	f04f 0400 	mov.w	r4, #0
 8000cc8:	d002      	beq.n	8000cd0 <esp8266_get_nonblocking+0x1a>
 8000cca:	f803 4b01 	strb.w	r4, [r3], #1
 8000cce:	e7f8      	b.n	8000cc2 <esp8266_get_nonblocking+0xc>
 8000cd0:	f000 ffba 	bl	8001c48 <timer_get_time>
 8000cd4:	4405      	add	r5, r0
 8000cd6:	f001 fb69 	bl	80023ac <uart_is_char>
 8000cda:	f64f 73ff 	movw	r3, #65535	; 0xffff
 8000cde:	4298      	cmp	r0, r3
 8000ce0:	bf1c      	itt	ne
 8000ce2:	5530      	strbne	r0, [r6, r4]
 8000ce4:	3401      	addne	r4, #1
 8000ce6:	f000 ffaf 	bl	8001c48 <timer_get_time>
 8000cea:	42bc      	cmp	r4, r7
 8000cec:	d207      	bcs.n	8000cfe <esp8266_get_nonblocking+0x48>
 8000cee:	4285      	cmp	r5, r0
 8000cf0:	d8f1      	bhi.n	8000cd6 <esp8266_get_nonblocking+0x20>
 8000cf2:	42a8      	cmp	r0, r5
 8000cf4:	bf94      	ite	ls
 8000cf6:	4620      	movls	r0, r4
 8000cf8:	f04f 30ff 	movhi.w	r0, #4294967295	; 0xffffffff
 8000cfc:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
 8000cfe:	42a8      	cmp	r0, r5
 8000d00:	bf94      	ite	ls
 8000d02:	f06f 0001 	mvnls.w	r0, #1
 8000d06:	f04f 30ff 	movhi.w	r0, #4294967295	; 0xffffffff
 8000d0a:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}

08000d0c <charging_send_message>:
 8000d0c:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
 8000d10:	4f4b      	ldr	r7, [pc, #300]	; (8000e40 <charging_send_message+0x134>)
 8000d12:	461e      	mov	r6, r3
 8000d14:	683b      	ldr	r3, [r7, #0]
 8000d16:	2b01      	cmp	r3, #1
 8000d18:	4681      	mov	r9, r0
 8000d1a:	4688      	mov	r8, r1
 8000d1c:	4614      	mov	r4, r2
 8000d1e:	463d      	mov	r5, r7
 8000d20:	d022      	beq.n	8000d68 <charging_send_message+0x5c>
 8000d22:	4848      	ldr	r0, [pc, #288]	; (8000e44 <charging_send_message+0x138>)
 8000d24:	f7ff ff2e 	bl	8000b84 <esp8266_send>
 8000d28:	2064      	movs	r0, #100	; 0x64
 8000d2a:	f000 ff9b 	bl	8001c64 <timer_delay_ms>
 8000d2e:	4846      	ldr	r0, [pc, #280]	; (8000e48 <charging_send_message+0x13c>)
 8000d30:	f7ff ff28 	bl	8000b84 <esp8266_send>
 8000d34:	4648      	mov	r0, r9
 8000d36:	f7ff ff25 	bl	8000b84 <esp8266_send>
 8000d3a:	4844      	ldr	r0, [pc, #272]	; (8000e4c <charging_send_message+0x140>)
 8000d3c:	f7ff ff22 	bl	8000b84 <esp8266_send>
 8000d40:	4640      	mov	r0, r8
 8000d42:	f7ff ff28 	bl	8000b96 <esp8266_send_uint>
 8000d46:	4842      	ldr	r0, [pc, #264]	; (8000e50 <charging_send_message+0x144>)
 8000d48:	f7ff ff1c 	bl	8000b84 <esp8266_send>
 8000d4c:	4841      	ldr	r0, [pc, #260]	; (8000e54 <charging_send_message+0x148>)
 8000d4e:	2107      	movs	r1, #7
 8000d50:	f44f 7261 	mov.w	r2, #900	; 0x384
 8000d54:	f7ff ff36 	bl	8000bc4 <esp8266_find_stream>
 8000d58:	b920      	cbnz	r0, 8000d64 <charging_send_message+0x58>
 8000d5a:	6038      	str	r0, [r7, #0]
 8000d5c:	f06f 0002 	mvn.w	r0, #2
 8000d60:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000d64:	2301      	movs	r3, #1
 8000d66:	603b      	str	r3, [r7, #0]
 8000d68:	483b      	ldr	r0, [pc, #236]	; (8000e58 <charging_send_message+0x14c>)
 8000d6a:	f7ff ff0b 	bl	8000b84 <esp8266_send>
 8000d6e:	4630      	mov	r0, r6
 8000d70:	f7ff ff11 	bl	8000b96 <esp8266_send_uint>
 8000d74:	4836      	ldr	r0, [pc, #216]	; (8000e50 <charging_send_message+0x144>)
 8000d76:	f7ff ff05 	bl	8000b84 <esp8266_send>
 8000d7a:	4838      	ldr	r0, [pc, #224]	; (8000e5c <charging_send_message+0x150>)
 8000d7c:	2101      	movs	r1, #1
 8000d7e:	f242 7210 	movw	r2, #10000	; 0x2710
 8000d82:	f7ff ff1f 	bl	8000bc4 <esp8266_find_stream>
 8000d86:	4607      	mov	r7, r0
 8000d88:	b108      	cbz	r0, 8000d8e <charging_send_message+0x82>
 8000d8a:	4426      	add	r6, r4
 8000d8c:	e00a      	b.n	8000da4 <charging_send_message+0x98>
 8000d8e:	482d      	ldr	r0, [pc, #180]	; (8000e44 <charging_send_message+0x138>)
 8000d90:	f7ff fef8 	bl	8000b84 <esp8266_send>
 8000d94:	2064      	movs	r0, #100	; 0x64
 8000d96:	f000 ff65 	bl	8001c64 <timer_delay_ms>
 8000d9a:	602f      	str	r7, [r5, #0]
 8000d9c:	f06f 0003 	mvn.w	r0, #3
 8000da0:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000da4:	42b4      	cmp	r4, r6
 8000da6:	d004      	beq.n	8000db2 <charging_send_message+0xa6>
 8000da8:	f814 0b01 	ldrb.w	r0, [r4], #1
 8000dac:	f001 faf2 	bl	8002394 <uart_write>
 8000db0:	e7f8      	b.n	8000da4 <charging_send_message+0x98>
 8000db2:	482b      	ldr	r0, [pc, #172]	; (8000e60 <charging_send_message+0x154>)
 8000db4:	2107      	movs	r1, #7
 8000db6:	f242 7210 	movw	r2, #10000	; 0x2710
 8000dba:	f7ff ff03 	bl	8000bc4 <esp8266_find_stream>
 8000dbe:	4604      	mov	r4, r0
 8000dc0:	b950      	cbnz	r0, 8000dd8 <charging_send_message+0xcc>
 8000dc2:	4820      	ldr	r0, [pc, #128]	; (8000e44 <charging_send_message+0x138>)
 8000dc4:	f7ff fede 	bl	8000b84 <esp8266_send>
 8000dc8:	2064      	movs	r0, #100	; 0x64
 8000dca:	f000 ff4b 	bl	8001c64 <timer_delay_ms>
 8000dce:	602c      	str	r4, [r5, #0]
 8000dd0:	f06f 0004 	mvn.w	r0, #4
 8000dd4:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000dd8:	4822      	ldr	r0, [pc, #136]	; (8000e64 <charging_send_message+0x158>)
 8000dda:	2105      	movs	r1, #5
 8000ddc:	f242 7210 	movw	r2, #10000	; 0x2710
 8000de0:	f7ff fef0 	bl	8000bc4 <esp8266_find_stream>
 8000de4:	4604      	mov	r4, r0
 8000de6:	b950      	cbnz	r0, 8000dfe <charging_send_message+0xf2>
 8000de8:	4816      	ldr	r0, [pc, #88]	; (8000e44 <charging_send_message+0x138>)
 8000dea:	f7ff fecb 	bl	8000b84 <esp8266_send>
 8000dee:	2064      	movs	r0, #100	; 0x64
 8000df0:	f000 ff38 	bl	8001c64 <timer_delay_ms>
 8000df4:	602c      	str	r4, [r5, #0]
 8000df6:	f06f 0005 	mvn.w	r0, #5
 8000dfa:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000dfe:	2400      	movs	r4, #0
 8000e00:	f001 faf0 	bl	80023e4 <uart_read>
 8000e04:	283a      	cmp	r0, #58	; 0x3a
 8000e06:	d005      	beq.n	8000e14 <charging_send_message+0x108>
 8000e08:	230a      	movs	r3, #10
 8000e0a:	fb03 0004 	mla	r0, r3, r4, r0
 8000e0e:	f1a0 0430 	sub.w	r4, r0, #48	; 0x30
 8000e12:	e7f5      	b.n	8000e00 <charging_send_message+0xf4>
 8000e14:	9909      	ldr	r1, [sp, #36]	; 0x24
 8000e16:	9808      	ldr	r0, [sp, #32]
 8000e18:	220a      	movs	r2, #10
 8000e1a:	f7ff ff4c 	bl	8000cb6 <esp8266_get_nonblocking>
 8000e1e:	4809      	ldr	r0, [pc, #36]	; (8000e44 <charging_send_message+0x138>)
 8000e20:	f7ff feb0 	bl	8000b84 <esp8266_send>
 8000e24:	2064      	movs	r0, #100	; 0x64
 8000e26:	f000 ff1d 	bl	8001c64 <timer_delay_ms>
 8000e2a:	4806      	ldr	r0, [pc, #24]	; (8000e44 <charging_send_message+0x138>)
 8000e2c:	f7ff feaa 	bl	8000b84 <esp8266_send>
 8000e30:	2064      	movs	r0, #100	; 0x64
 8000e32:	f000 ff17 	bl	8001c64 <timer_delay_ms>
 8000e36:	2300      	movs	r3, #0
 8000e38:	602b      	str	r3, [r5, #0]
 8000e3a:	4620      	mov	r0, r4
 8000e3c:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000e40:	20000204 	.word	0x20000204
 8000e44:	08002b84 	.word	0x08002b84
 8000e48:	08002b92 	.word	0x08002b92
 8000e4c:	08002ba6 	.word	0x08002ba6
 8000e50:	08002b6d 	.word	0x08002b6d
 8000e54:	08002ba9 	.word	0x08002ba9
 8000e58:	08002bb1 	.word	0x08002bb1
 8000e5c:	08002bbd 	.word	0x08002bbd
 8000e60:	08002bbf 	.word	0x08002bbf
 8000e64:	08002bc7 	.word	0x08002bc7

08000e68 <tcp_init>:
 8000e68:	4a0f      	ldr	r2, [pc, #60]	; (8000ea8 <tcp_init+0x40>)
 8000e6a:	2300      	movs	r3, #0
 8000e6c:	6013      	str	r3, [r2, #0]
 8000e6e:	4611      	mov	r1, r2
 8000e70:	18c8      	adds	r0, r1, r3
 8000e72:	3301      	adds	r3, #1
 8000e74:	2200      	movs	r2, #0
 8000e76:	2b40      	cmp	r3, #64	; 0x40
 8000e78:	7102      	strb	r2, [r0, #4]
 8000e7a:	d1f9      	bne.n	8000e70 <tcp_init+0x8>
 8000e7c:	4b0b      	ldr	r3, [pc, #44]	; (8000eac <tcp_init+0x44>)
 8000e7e:	490c      	ldr	r1, [pc, #48]	; (8000eb0 <tcp_init+0x48>)
 8000e80:	6019      	str	r1, [r3, #0]
 8000e82:	490c      	ldr	r1, [pc, #48]	; (8000eb4 <tcp_init+0x4c>)
 8000e84:	6059      	str	r1, [r3, #4]
 8000e86:	490c      	ldr	r1, [pc, #48]	; (8000eb8 <tcp_init+0x50>)
 8000e88:	6099      	str	r1, [r3, #8]
 8000e8a:	4907      	ldr	r1, [pc, #28]	; (8000ea8 <tcp_init+0x40>)
 8000e8c:	60d9      	str	r1, [r3, #12]
 8000e8e:	490b      	ldr	r1, [pc, #44]	; (8000ebc <tcp_init+0x54>)
 8000e90:	2300      	movs	r3, #0
 8000e92:	5453      	strb	r3, [r2, r1]
 8000e94:	3201      	adds	r2, #1
 8000e96:	2a80      	cmp	r2, #128	; 0x80
 8000e98:	d1f9      	bne.n	8000e8e <tcp_init+0x26>
 8000e9a:	4a09      	ldr	r2, [pc, #36]	; (8000ec0 <tcp_init+0x58>)
 8000e9c:	2100      	movs	r1, #0
 8000e9e:	5499      	strb	r1, [r3, r2]
 8000ea0:	3301      	adds	r3, #1
 8000ea2:	2b80      	cmp	r3, #128	; 0x80
 8000ea4:	d1f9      	bne.n	8000e9a <tcp_init+0x32>
 8000ea6:	4770      	bx	lr
 8000ea8:	20000288 	.word	0x20000288
 8000eac:	200002cc 	.word	0x200002cc
 8000eb0:	20000064 	.word	0x20000064
 8000eb4:	200000ec 	.word	0x200000ec
 8000eb8:	20000034 	.word	0x20000034
 8000ebc:	20000208 	.word	0x20000208
 8000ec0:	200002dc 	.word	0x200002dc

08000ec4 <motors_uninit>:
 8000ec4:	b508      	push	{r3, lr}
 8000ec6:	20c2      	movs	r0, #194	; 0xc2
 8000ec8:	2100      	movs	r1, #0
 8000eca:	2218      	movs	r2, #24
 8000ecc:	f001 fde0 	bl	8002a90 <i2c_write_reg>
 8000ed0:	20c6      	movs	r0, #198	; 0xc6
 8000ed2:	2100      	movs	r1, #0
 8000ed4:	2218      	movs	r2, #24
 8000ed6:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8000eda:	f001 bdd9 	b.w	8002a90 <i2c_write_reg>
	...

08000ee0 <motors_update>:
 8000ee0:	b538      	push	{r3, r4, r5, lr}
 8000ee2:	4b41      	ldr	r3, [pc, #260]	; (8000fe8 <motors_update+0x108>)
 8000ee4:	681c      	ldr	r4, [r3, #0]
 8000ee6:	685d      	ldr	r5, [r3, #4]
 8000ee8:	b2e4      	uxtb	r4, r4
 8000eea:	b262      	sxtb	r2, r4
 8000eec:	b2ed      	uxtb	r5, r5
 8000eee:	2a2c      	cmp	r2, #44	; 0x2c
 8000ef0:	b26b      	sxtb	r3, r5
 8000ef2:	dc07      	bgt.n	8000f04 <motors_update+0x24>
 8000ef4:	322c      	adds	r2, #44	; 0x2c
 8000ef6:	db6e      	blt.n	8000fd6 <motors_update+0xf6>
 8000ef8:	2b2c      	cmp	r3, #44	; 0x2c
 8000efa:	dc5d      	bgt.n	8000fb8 <motors_update+0xd8>
 8000efc:	332c      	adds	r3, #44	; 0x2c
 8000efe:	db34      	blt.n	8000f6a <motors_update+0x8a>
 8000f00:	b1e4      	cbz	r4, 8000f3c <motors_update+0x5c>
 8000f02:	e003      	b.n	8000f0c <motors_update+0x2c>
 8000f04:	242c      	movs	r4, #44	; 0x2c
 8000f06:	42a3      	cmp	r3, r4
 8000f08:	ddf8      	ble.n	8000efc <motors_update+0x1c>
 8000f0a:	4625      	mov	r5, r4
 8000f0c:	b263      	sxtb	r3, r4
 8000f0e:	2b00      	cmp	r3, #0
 8000f10:	dd08      	ble.n	8000f24 <motors_update+0x44>
 8000f12:	2b05      	cmp	r3, #5
 8000f14:	bfd8      	it	le
 8000f16:	2406      	movle	r4, #6
 8000f18:	b264      	sxtb	r4, r4
 8000f1a:	00a4      	lsls	r4, r4, #2
 8000f1c:	f044 0402 	orr.w	r4, r4, #2
 8000f20:	e00a      	b.n	8000f38 <motors_update+0x58>
 8000f22:	252c      	movs	r5, #44	; 0x2c
 8000f24:	4264      	negs	r4, r4
 8000f26:	b2e4      	uxtb	r4, r4
 8000f28:	2c05      	cmp	r4, #5
 8000f2a:	bf8c      	ite	hi
 8000f2c:	b2e4      	uxtbhi	r4, r4
 8000f2e:	2406      	movls	r4, #6
 8000f30:	b264      	sxtb	r4, r4
 8000f32:	00a4      	lsls	r4, r4, #2
 8000f34:	f044 0401 	orr.w	r4, r4, #1
 8000f38:	b2e4      	uxtb	r4, r4
 8000f3a:	e000      	b.n	8000f3e <motors_update+0x5e>
 8000f3c:	241b      	movs	r4, #27
 8000f3e:	2100      	movs	r1, #0
 8000f40:	460a      	mov	r2, r1
 8000f42:	20c2      	movs	r0, #194	; 0xc2
 8000f44:	f001 fda4 	bl	8002a90 <i2c_write_reg>
 8000f48:	20c2      	movs	r0, #194	; 0xc2
 8000f4a:	2100      	movs	r1, #0
 8000f4c:	4622      	mov	r2, r4
 8000f4e:	f001 fd9f 	bl	8002a90 <i2c_write_reg>
 8000f52:	b315      	cbz	r5, 8000f9a <motors_update+0xba>
 8000f54:	b26b      	sxtb	r3, r5
 8000f56:	2b00      	cmp	r3, #0
 8000f58:	dd13      	ble.n	8000f82 <motors_update+0xa2>
 8000f5a:	2b05      	cmp	r3, #5
 8000f5c:	bfd8      	it	le
 8000f5e:	2506      	movle	r5, #6
 8000f60:	b26d      	sxtb	r5, r5
 8000f62:	00ad      	lsls	r5, r5, #2
 8000f64:	f045 0501 	orr.w	r5, r5, #1
 8000f68:	e015      	b.n	8000f96 <motors_update+0xb6>
 8000f6a:	bb1c      	cbnz	r4, 8000fb4 <motors_update+0xd4>
 8000f6c:	20c2      	movs	r0, #194	; 0xc2
 8000f6e:	4621      	mov	r1, r4
 8000f70:	4622      	mov	r2, r4
 8000f72:	f001 fd8d 	bl	8002a90 <i2c_write_reg>
 8000f76:	20c2      	movs	r0, #194	; 0xc2
 8000f78:	4621      	mov	r1, r4
 8000f7a:	221b      	movs	r2, #27
 8000f7c:	f001 fd88 	bl	8002a90 <i2c_write_reg>
 8000f80:	25d4      	movs	r5, #212	; 0xd4
 8000f82:	426d      	negs	r5, r5
 8000f84:	b2ed      	uxtb	r5, r5
 8000f86:	2d05      	cmp	r5, #5
 8000f88:	bf8c      	ite	hi
 8000f8a:	b2ed      	uxtbhi	r5, r5
 8000f8c:	2506      	movls	r5, #6
 8000f8e:	b26d      	sxtb	r5, r5
 8000f90:	00ad      	lsls	r5, r5, #2
 8000f92:	f045 0502 	orr.w	r5, r5, #2
 8000f96:	b2ed      	uxtb	r5, r5
 8000f98:	e000      	b.n	8000f9c <motors_update+0xbc>
 8000f9a:	251b      	movs	r5, #27
 8000f9c:	2100      	movs	r1, #0
 8000f9e:	460a      	mov	r2, r1
 8000fa0:	20c6      	movs	r0, #198	; 0xc6
 8000fa2:	f001 fd75 	bl	8002a90 <i2c_write_reg>
 8000fa6:	462a      	mov	r2, r5
 8000fa8:	20c6      	movs	r0, #198	; 0xc6
 8000faa:	2100      	movs	r1, #0
 8000fac:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
 8000fb0:	f001 bd6e 	b.w	8002a90 <i2c_write_reg>
 8000fb4:	25d4      	movs	r5, #212	; 0xd4
 8000fb6:	e7a9      	b.n	8000f0c <motors_update+0x2c>
 8000fb8:	b95c      	cbnz	r4, 8000fd2 <motors_update+0xf2>
 8000fba:	20c2      	movs	r0, #194	; 0xc2
 8000fbc:	4621      	mov	r1, r4
 8000fbe:	4622      	mov	r2, r4
 8000fc0:	f001 fd66 	bl	8002a90 <i2c_write_reg>
 8000fc4:	20c2      	movs	r0, #194	; 0xc2
 8000fc6:	4621      	mov	r1, r4
 8000fc8:	221b      	movs	r2, #27
 8000fca:	f001 fd61 	bl	8002a90 <i2c_write_reg>
 8000fce:	252c      	movs	r5, #44	; 0x2c
 8000fd0:	e7c6      	b.n	8000f60 <motors_update+0x80>
 8000fd2:	252c      	movs	r5, #44	; 0x2c
 8000fd4:	e79a      	b.n	8000f0c <motors_update+0x2c>
 8000fd6:	2b2c      	cmp	r3, #44	; 0x2c
 8000fd8:	f04f 04d4 	mov.w	r4, #212	; 0xd4
 8000fdc:	dca1      	bgt.n	8000f22 <motors_update+0x42>
 8000fde:	332d      	adds	r3, #45	; 0x2d
 8000fe0:	bfd8      	it	le
 8000fe2:	4625      	movle	r5, r4
 8000fe4:	e792      	b.n	8000f0c <motors_update+0x2c>
 8000fe6:	bf00      	nop
 8000fe8:	200000e4 	.word	0x200000e4

08000fec <motors_init>:
 8000fec:	b510      	push	{r4, lr}
 8000fee:	4b04      	ldr	r3, [pc, #16]	; (8001000 <motors_init+0x14>)
 8000ff0:	2400      	movs	r4, #0
 8000ff2:	601c      	str	r4, [r3, #0]
 8000ff4:	605c      	str	r4, [r3, #4]
 8000ff6:	f7ff ff73 	bl	8000ee0 <motors_update>
 8000ffa:	4620      	mov	r0, r4
 8000ffc:	bd10      	pop	{r4, pc}
 8000ffe:	bf00      	nop
 8001000:	200000e4 	.word	0x200000e4

08001004 <thread_ending>:
 8001004:	b672      	cpsid	i
 8001006:	4b05      	ldr	r3, [pc, #20]	; (800101c <thread_ending+0x18>)
 8001008:	681a      	ldr	r2, [r3, #0]
 800100a:	4b05      	ldr	r3, [pc, #20]	; (8001020 <thread_ending+0x1c>)
 800100c:	210c      	movs	r1, #12
 800100e:	fb01 3302 	mla	r3, r1, r2, r3
 8001012:	2200      	movs	r2, #0
 8001014:	605a      	str	r2, [r3, #4]
 8001016:	b662      	cpsie	i
 8001018:	bf00      	nop
 800101a:	e7fd      	b.n	8001018 <thread_ending+0x14>
 800101c:	200003a4 	.word	0x200003a4
 8001020:	2000035c 	.word	0x2000035c

08001024 <null_thread>:
 8001024:	b508      	push	{r3, lr}
 8001026:	f001 facd 	bl	80025c4 <sleep>
 800102a:	e7fc      	b.n	8001026 <null_thread+0x2>

0800102c <scheduler>:
 800102c:	b570      	push	{r4, r5, r6, lr}
 800102e:	2200      	movs	r2, #0
 8001030:	4611      	mov	r1, r2
 8001032:	4b15      	ldr	r3, [pc, #84]	; (8001088 <scheduler+0x5c>)
 8001034:	200c      	movs	r0, #12
 8001036:	fb00 f401 	mul.w	r4, r0, r1
 800103a:	191e      	adds	r6, r3, r4
 800103c:	6875      	ldr	r5, [r6, #4]
 800103e:	f015 0f02 	tst.w	r5, #2
 8001042:	461d      	mov	r5, r3
 8001044:	d10a      	bne.n	800105c <scheduler+0x30>
 8001046:	6876      	ldr	r6, [r6, #4]
 8001048:	07f6      	lsls	r6, r6, #31
 800104a:	d507      	bpl.n	800105c <scheduler+0x30>
 800104c:	4350      	muls	r0, r2
 800104e:	5b1c      	ldrh	r4, [r3, r4]
 8001050:	5a18      	ldrh	r0, [r3, r0]
 8001052:	b2a4      	uxth	r4, r4
 8001054:	b280      	uxth	r0, r0
 8001056:	4284      	cmp	r4, r0
 8001058:	bf38      	it	cc
 800105a:	460a      	movcc	r2, r1
 800105c:	200c      	movs	r0, #12
 800105e:	4348      	muls	r0, r1
 8001060:	5a1c      	ldrh	r4, [r3, r0]
 8001062:	b2a4      	uxth	r4, r4
 8001064:	b11c      	cbz	r4, 800106e <scheduler+0x42>
 8001066:	5a1c      	ldrh	r4, [r3, r0]
 8001068:	3c01      	subs	r4, #1
 800106a:	b2a4      	uxth	r4, r4
 800106c:	521c      	strh	r4, [r3, r0]
 800106e:	3101      	adds	r1, #1
 8001070:	2906      	cmp	r1, #6
 8001072:	d1de      	bne.n	8001032 <scheduler+0x6>
 8001074:	230c      	movs	r3, #12
 8001076:	4353      	muls	r3, r2
 8001078:	18e9      	adds	r1, r5, r3
 800107a:	8849      	ldrh	r1, [r1, #2]
 800107c:	b289      	uxth	r1, r1
 800107e:	52e9      	strh	r1, [r5, r3]
 8001080:	4b02      	ldr	r3, [pc, #8]	; (800108c <scheduler+0x60>)
 8001082:	601a      	str	r2, [r3, #0]
 8001084:	bd70      	pop	{r4, r5, r6, pc}
 8001086:	bf00      	nop
 8001088:	2000035c 	.word	0x2000035c
 800108c:	200003a4 	.word	0x200003a4

08001090 <SysTick_Handler>:
 8001090:	e92d 0ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
 8001094:	f3ef 8308 	mrs	r3, MSP
 8001098:	4c0d      	ldr	r4, [pc, #52]	; (80010d0 <SysTick_Handler+0x40>)
 800109a:	4d0e      	ldr	r5, [pc, #56]	; (80010d4 <SysTick_Handler+0x44>)
 800109c:	6822      	ldr	r2, [r4, #0]
 800109e:	3201      	adds	r2, #1
 80010a0:	bf1d      	ittte	ne
 80010a2:	6822      	ldrne	r2, [r4, #0]
 80010a4:	210c      	movne	r1, #12
 80010a6:	fb01 5202 	mlane	r2, r1, r2, r5
 80010aa:	2300      	moveq	r3, #0
 80010ac:	bf14      	ite	ne
 80010ae:	6093      	strne	r3, [r2, #8]
 80010b0:	6023      	streq	r3, [r4, #0]
 80010b2:	f7ff ffbb 	bl	800102c <scheduler>
 80010b6:	6822      	ldr	r2, [r4, #0]
 80010b8:	230c      	movs	r3, #12
 80010ba:	fb03 5302 	mla	r3, r3, r2, r5
 80010be:	689a      	ldr	r2, [r3, #8]
 80010c0:	f06f 0306 	mvn.w	r3, #6
 80010c4:	469e      	mov	lr, r3
 80010c6:	f382 8808 	msr	MSP, r2
 80010ca:	e8bd 0ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
 80010ce:	4770      	bx	lr
 80010d0:	200003a4 	.word	0x200003a4
 80010d4:	2000035c 	.word	0x2000035c

080010d8 <sched_off>:
 80010d8:	b672      	cpsid	i
 80010da:	4770      	bx	lr

080010dc <sched_on>:
 80010dc:	b662      	cpsie	i
 80010de:	4770      	bx	lr

080010e0 <yield>:
 80010e0:	bf00      	nop
 80010e2:	4770      	bx	lr

080010e4 <get_thread_id>:
 80010e4:	b082      	sub	sp, #8
 80010e6:	b672      	cpsid	i
 80010e8:	4b03      	ldr	r3, [pc, #12]	; (80010f8 <get_thread_id+0x14>)
 80010ea:	681b      	ldr	r3, [r3, #0]
 80010ec:	9301      	str	r3, [sp, #4]
 80010ee:	b662      	cpsie	i
 80010f0:	9801      	ldr	r0, [sp, #4]
 80010f2:	b002      	add	sp, #8
 80010f4:	4770      	bx	lr
 80010f6:	bf00      	nop
 80010f8:	200003a4 	.word	0x200003a4

080010fc <kernel_start>:
 80010fc:	b508      	push	{r3, lr}
 80010fe:	f001 fa4f 	bl	80025a0 <sys_tick_init>
 8001102:	bf00      	nop
 8001104:	e7fd      	b.n	8001102 <kernel_start+0x6>
	...

08001108 <create_thread>:
 8001108:	f022 0203 	bic.w	r2, r2, #3
 800110c:	3a40      	subs	r2, #64	; 0x40
 800110e:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
 8001112:	eb01 0e02 	add.w	lr, r1, r2
 8001116:	f102 0634 	add.w	r6, r2, #52	; 0x34
 800111a:	f102 0738 	add.w	r7, r2, #56	; 0x38
 800111e:	323c      	adds	r2, #60	; 0x3c
 8001120:	440e      	add	r6, r1
 8001122:	440f      	add	r7, r1
 8001124:	4411      	add	r1, r2
 8001126:	2200      	movs	r2, #0
 8001128:	b672      	cpsid	i
 800112a:	f8df c054 	ldr.w	ip, [pc, #84]	; 8001180 <create_thread+0x78>
 800112e:	250c      	movs	r5, #12
 8001130:	4355      	muls	r5, r2
 8001132:	eb0c 0405 	add.w	r4, ip, r5
 8001136:	f8d4 8004 	ldr.w	r8, [r4, #4]
 800113a:	f018 0f01 	tst.w	r8, #1
 800113e:	d114      	bne.n	800116a <create_thread+0x62>
 8001140:	f8df 8040 	ldr.w	r8, [pc, #64]	; 8001184 <create_thread+0x7c>
 8001144:	f8c4 e008 	str.w	lr, [r4, #8]
 8001148:	2b05      	cmp	r3, #5
 800114a:	f8c6 8000 	str.w	r8, [r6]
 800114e:	bf98      	it	ls
 8001150:	2306      	movls	r3, #6
 8001152:	f04f 5804 	mov.w	r8, #553648128	; 0x21000000
 8001156:	6038      	str	r0, [r7, #0]
 8001158:	f8c1 8000 	str.w	r8, [r1]
 800115c:	8063      	strh	r3, [r4, #2]
 800115e:	f82c 3005 	strh.w	r3, [ip, r5]
 8001162:	2501      	movs	r5, #1
 8001164:	6065      	str	r5, [r4, #4]
 8001166:	4614      	mov	r4, r2
 8001168:	e000      	b.n	800116c <create_thread+0x64>
 800116a:	2406      	movs	r4, #6
 800116c:	b662      	cpsie	i
 800116e:	3201      	adds	r2, #1
 8001170:	2a06      	cmp	r2, #6
 8001172:	d001      	beq.n	8001178 <create_thread+0x70>
 8001174:	2c06      	cmp	r4, #6
 8001176:	d0d7      	beq.n	8001128 <create_thread+0x20>
 8001178:	4620      	mov	r0, r4
 800117a:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 800117e:	bf00      	nop
 8001180:	2000035c 	.word	0x2000035c
 8001184:	08001005 	.word	0x08001005

08001188 <kernel_init>:
 8001188:	b510      	push	{r4, lr}
 800118a:	2300      	movs	r3, #0
 800118c:	490b      	ldr	r1, [pc, #44]	; (80011bc <kernel_init+0x34>)
 800118e:	220c      	movs	r2, #12
 8001190:	435a      	muls	r2, r3
 8001192:	188c      	adds	r4, r1, r2
 8001194:	2000      	movs	r0, #0
 8001196:	6060      	str	r0, [r4, #4]
 8001198:	3301      	adds	r3, #1
 800119a:	2006      	movs	r0, #6
 800119c:	4283      	cmp	r3, r0
 800119e:	8060      	strh	r0, [r4, #2]
 80011a0:	5288      	strh	r0, [r1, r2]
 80011a2:	d1f3      	bne.n	800118c <kernel_init+0x4>
 80011a4:	4b06      	ldr	r3, [pc, #24]	; (80011c0 <kernel_init+0x38>)
 80011a6:	4807      	ldr	r0, [pc, #28]	; (80011c4 <kernel_init+0x3c>)
 80011a8:	4907      	ldr	r1, [pc, #28]	; (80011c8 <kernel_init+0x40>)
 80011aa:	f04f 32ff 	mov.w	r2, #4294967295	; 0xffffffff
 80011ae:	601a      	str	r2, [r3, #0]
 80011b0:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 80011b4:	2280      	movs	r2, #128	; 0x80
 80011b6:	23ff      	movs	r3, #255	; 0xff
 80011b8:	f7ff bfa6 	b.w	8001108 <create_thread>
 80011bc:	2000035c 	.word	0x2000035c
 80011c0:	200003a4 	.word	0x200003a4
 80011c4:	08001025 	.word	0x08001025
 80011c8:	200003a8 	.word	0x200003a8

080011cc <set_wait_state>:
 80011cc:	b507      	push	{r0, r1, r2, lr}
 80011ce:	f7ff ff89 	bl	80010e4 <get_thread_id>
 80011d2:	9000      	str	r0, [sp, #0]
 80011d4:	b672      	cpsid	i
 80011d6:	4b0d      	ldr	r3, [pc, #52]	; (800120c <set_wait_state+0x40>)
 80011d8:	9a00      	ldr	r2, [sp, #0]
 80011da:	210c      	movs	r1, #12
 80011dc:	fb01 3202 	mla	r2, r1, r2, r3
 80011e0:	6851      	ldr	r1, [r2, #4]
 80011e2:	f041 0102 	orr.w	r1, r1, #2
 80011e6:	6051      	str	r1, [r2, #4]
 80011e8:	b672      	cpsid	i
 80011ea:	9a00      	ldr	r2, [sp, #0]
 80011ec:	210c      	movs	r1, #12
 80011ee:	fb01 3202 	mla	r2, r1, r2, r3
 80011f2:	6852      	ldr	r2, [r2, #4]
 80011f4:	9201      	str	r2, [sp, #4]
 80011f6:	b662      	cpsie	i
 80011f8:	9a01      	ldr	r2, [sp, #4]
 80011fa:	0791      	lsls	r1, r2, #30
 80011fc:	d500      	bpl.n	8001200 <set_wait_state+0x34>
 80011fe:	bf00      	nop
 8001200:	9a01      	ldr	r2, [sp, #4]
 8001202:	0792      	lsls	r2, r2, #30
 8001204:	d4f0      	bmi.n	80011e8 <set_wait_state+0x1c>
 8001206:	b003      	add	sp, #12
 8001208:	f85d fb04 	ldr.w	pc, [sp], #4
 800120c:	2000035c 	.word	0x2000035c

08001210 <wake_up_threads>:
 8001210:	2300      	movs	r3, #0
 8001212:	b672      	cpsid	i
 8001214:	4906      	ldr	r1, [pc, #24]	; (8001230 <wake_up_threads+0x20>)
 8001216:	220c      	movs	r2, #12
 8001218:	fb02 1203 	mla	r2, r2, r3, r1
 800121c:	6851      	ldr	r1, [r2, #4]
 800121e:	f021 0102 	bic.w	r1, r1, #2
 8001222:	6051      	str	r1, [r2, #4]
 8001224:	b662      	cpsie	i
 8001226:	3301      	adds	r3, #1
 8001228:	2b06      	cmp	r3, #6
 800122a:	d1f2      	bne.n	8001212 <wake_up_threads+0x2>
 800122c:	4770      	bx	lr
 800122e:	bf00      	nop
 8001230:	2000035c 	.word	0x2000035c

08001234 <putc_>:
 8001234:	b538      	push	{r3, r4, r5, lr}
 8001236:	4c06      	ldr	r4, [pc, #24]	; (8001250 <putc_+0x1c>)
 8001238:	4605      	mov	r5, r0
 800123a:	4620      	mov	r0, r4
 800123c:	f000 f8f8 	bl	8001430 <mutex_lock>
 8001240:	4628      	mov	r0, r5
 8001242:	f001 f8a7 	bl	8002394 <uart_write>
 8001246:	4620      	mov	r0, r4
 8001248:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
 800124c:	f000 b90c 	b.w	8001468 <mutex_unlock>
 8001250:	20000428 	.word	0x20000428

08001254 <puts_>:
 8001254:	b510      	push	{r4, lr}
 8001256:	4604      	mov	r4, r0
 8001258:	4807      	ldr	r0, [pc, #28]	; (8001278 <puts_+0x24>)
 800125a:	f000 f8e9 	bl	8001430 <mutex_lock>
 800125e:	3c01      	subs	r4, #1
 8001260:	f814 0f01 	ldrb.w	r0, [r4, #1]!
 8001264:	b110      	cbz	r0, 800126c <puts_+0x18>
 8001266:	f7ff ffe5 	bl	8001234 <putc_>
 800126a:	e7f9      	b.n	8001260 <puts_+0xc>
 800126c:	4802      	ldr	r0, [pc, #8]	; (8001278 <puts_+0x24>)
 800126e:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 8001272:	f000 b8f9 	b.w	8001468 <mutex_unlock>
 8001276:	bf00      	nop
 8001278:	20000434 	.word	0x20000434

0800127c <puti_>:
 800127c:	b530      	push	{r4, r5, lr}
 800127e:	b085      	sub	sp, #20
 8001280:	1e03      	subs	r3, r0, #0
 8001282:	f04f 0200 	mov.w	r2, #0
 8001286:	bfba      	itte	lt
 8001288:	425b      	neglt	r3, r3
 800128a:	2401      	movlt	r4, #1
 800128c:	4614      	movge	r4, r2
 800128e:	f88d 200f 	strb.w	r2, [sp, #15]
 8001292:	210a      	movs	r1, #10
 8001294:	220a      	movs	r2, #10
 8001296:	a801      	add	r0, sp, #4
 8001298:	fb93 f5f2 	sdiv	r5, r3, r2
 800129c:	fb02 3315 	mls	r3, r2, r5, r3
 80012a0:	3330      	adds	r3, #48	; 0x30
 80012a2:	540b      	strb	r3, [r1, r0]
 80012a4:	1e4a      	subs	r2, r1, #1
 80012a6:	462b      	mov	r3, r5
 80012a8:	b10d      	cbz	r5, 80012ae <puti_+0x32>
 80012aa:	4611      	mov	r1, r2
 80012ac:	e7f2      	b.n	8001294 <puti_+0x18>
 80012ae:	b12c      	cbz	r4, 80012bc <puti_+0x40>
 80012b0:	ab04      	add	r3, sp, #16
 80012b2:	4413      	add	r3, r2
 80012b4:	212d      	movs	r1, #45	; 0x2d
 80012b6:	f803 1c0c 	strb.w	r1, [r3, #-12]
 80012ba:	4611      	mov	r1, r2
 80012bc:	4408      	add	r0, r1
 80012be:	f7ff ffc9 	bl	8001254 <puts_>
 80012c2:	b005      	add	sp, #20
 80012c4:	bd30      	pop	{r4, r5, pc}

080012c6 <putui_>:
 80012c6:	b51f      	push	{r0, r1, r2, r3, r4, lr}
 80012c8:	2300      	movs	r3, #0
 80012ca:	f88d 300f 	strb.w	r3, [sp, #15]
 80012ce:	220a      	movs	r2, #10
 80012d0:	230a      	movs	r3, #10
 80012d2:	a901      	add	r1, sp, #4
 80012d4:	fbb0 f4f3 	udiv	r4, r0, r3
 80012d8:	fb03 0314 	mls	r3, r3, r4, r0
 80012dc:	3330      	adds	r3, #48	; 0x30
 80012de:	5453      	strb	r3, [r2, r1]
 80012e0:	4620      	mov	r0, r4
 80012e2:	1e53      	subs	r3, r2, #1
 80012e4:	b10c      	cbz	r4, 80012ea <putui_+0x24>
 80012e6:	461a      	mov	r2, r3
 80012e8:	e7f2      	b.n	80012d0 <putui_+0xa>
 80012ea:	1888      	adds	r0, r1, r2
 80012ec:	f7ff ffb2 	bl	8001254 <puts_>
 80012f0:	b004      	add	sp, #16
 80012f2:	bd10      	pop	{r4, pc}

080012f4 <putx_>:
 80012f4:	b51f      	push	{r0, r1, r2, r3, r4, lr}
 80012f6:	2300      	movs	r3, #0
 80012f8:	f88d 300f 	strb.w	r3, [sp, #15]
 80012fc:	220a      	movs	r2, #10
 80012fe:	f000 030f 	and.w	r3, r0, #15
 8001302:	2b09      	cmp	r3, #9
 8001304:	a901      	add	r1, sp, #4
 8001306:	bf94      	ite	ls
 8001308:	3330      	addls	r3, #48	; 0x30
 800130a:	3357      	addhi	r3, #87	; 0x57
 800130c:	0900      	lsrs	r0, r0, #4
 800130e:	548b      	strb	r3, [r1, r2]
 8001310:	f102 33ff 	add.w	r3, r2, #4294967295	; 0xffffffff
 8001314:	d001      	beq.n	800131a <putx_+0x26>
 8001316:	461a      	mov	r2, r3
 8001318:	e7f1      	b.n	80012fe <putx_+0xa>
 800131a:	1888      	adds	r0, r1, r2
 800131c:	f7ff ff9a 	bl	8001254 <puts_>
 8001320:	b005      	add	sp, #20
 8001322:	f85d fb04 	ldr.w	pc, [sp], #4
	...

08001328 <printf_>:
 8001328:	b40f      	push	{r0, r1, r2, r3}
 800132a:	b537      	push	{r0, r1, r2, r4, r5, lr}
 800132c:	ac06      	add	r4, sp, #24
 800132e:	4826      	ldr	r0, [pc, #152]	; (80013c8 <printf_+0xa0>)
 8001330:	f854 5b04 	ldr.w	r5, [r4], #4
 8001334:	f000 f87c 	bl	8001430 <mutex_lock>
 8001338:	9401      	str	r4, [sp, #4]
 800133a:	2400      	movs	r4, #0
 800133c:	5d28      	ldrb	r0, [r5, r4]
 800133e:	2800      	cmp	r0, #0
 8001340:	d039      	beq.n	80013b6 <printf_+0x8e>
 8001342:	2825      	cmp	r0, #37	; 0x25
 8001344:	d003      	beq.n	800134e <printf_+0x26>
 8001346:	f7ff ff75 	bl	8001234 <putc_>
 800134a:	3401      	adds	r4, #1
 800134c:	e7f6      	b.n	800133c <printf_+0x14>
 800134e:	192b      	adds	r3, r5, r4
 8001350:	7858      	ldrb	r0, [r3, #1]
 8001352:	2869      	cmp	r0, #105	; 0x69
 8001354:	d016      	beq.n	8001384 <printf_+0x5c>
 8001356:	d808      	bhi.n	800136a <printf_+0x42>
 8001358:	2825      	cmp	r0, #37	; 0x25
 800135a:	d028      	beq.n	80013ae <printf_+0x86>
 800135c:	2863      	cmp	r0, #99	; 0x63
 800135e:	d128      	bne.n	80013b2 <printf_+0x8a>
 8001360:	9b01      	ldr	r3, [sp, #4]
 8001362:	1d1a      	adds	r2, r3, #4
 8001364:	9201      	str	r2, [sp, #4]
 8001366:	7818      	ldrb	r0, [r3, #0]
 8001368:	e021      	b.n	80013ae <printf_+0x86>
 800136a:	2875      	cmp	r0, #117	; 0x75
 800136c:	d011      	beq.n	8001392 <printf_+0x6a>
 800136e:	2878      	cmp	r0, #120	; 0x78
 8001370:	d016      	beq.n	80013a0 <printf_+0x78>
 8001372:	2873      	cmp	r0, #115	; 0x73
 8001374:	d11d      	bne.n	80013b2 <printf_+0x8a>
 8001376:	9b01      	ldr	r3, [sp, #4]
 8001378:	1d1a      	adds	r2, r3, #4
 800137a:	6818      	ldr	r0, [r3, #0]
 800137c:	9201      	str	r2, [sp, #4]
 800137e:	f7ff ff69 	bl	8001254 <puts_>
 8001382:	e016      	b.n	80013b2 <printf_+0x8a>
 8001384:	9b01      	ldr	r3, [sp, #4]
 8001386:	1d1a      	adds	r2, r3, #4
 8001388:	6818      	ldr	r0, [r3, #0]
 800138a:	9201      	str	r2, [sp, #4]
 800138c:	f7ff ff76 	bl	800127c <puti_>
 8001390:	e00f      	b.n	80013b2 <printf_+0x8a>
 8001392:	9b01      	ldr	r3, [sp, #4]
 8001394:	1d1a      	adds	r2, r3, #4
 8001396:	6818      	ldr	r0, [r3, #0]
 8001398:	9201      	str	r2, [sp, #4]
 800139a:	f7ff ff94 	bl	80012c6 <putui_>
 800139e:	e008      	b.n	80013b2 <printf_+0x8a>
 80013a0:	9b01      	ldr	r3, [sp, #4]
 80013a2:	1d1a      	adds	r2, r3, #4
 80013a4:	6818      	ldr	r0, [r3, #0]
 80013a6:	9201      	str	r2, [sp, #4]
 80013a8:	f7ff ffa4 	bl	80012f4 <putx_>
 80013ac:	e001      	b.n	80013b2 <printf_+0x8a>
 80013ae:	f7ff ff41 	bl	8001234 <putc_>
 80013b2:	3402      	adds	r4, #2
 80013b4:	e7c2      	b.n	800133c <printf_+0x14>
 80013b6:	4804      	ldr	r0, [pc, #16]	; (80013c8 <printf_+0xa0>)
 80013b8:	f000 f856 	bl	8001468 <mutex_unlock>
 80013bc:	b003      	add	sp, #12
 80013be:	e8bd 4030 	ldmia.w	sp!, {r4, r5, lr}
 80013c2:	b004      	add	sp, #16
 80013c4:	4770      	bx	lr
 80013c6:	bf00      	nop
 80013c8:	20000430 	.word	0x20000430

080013cc <stdio_init>:
 80013cc:	b510      	push	{r4, lr}
 80013ce:	480e      	ldr	r0, [pc, #56]	; (8001408 <stdio_init+0x3c>)
 80013d0:	f000 f824 	bl	800141c <mutex_init>
 80013d4:	480d      	ldr	r0, [pc, #52]	; (800140c <stdio_init+0x40>)
 80013d6:	f000 f821 	bl	800141c <mutex_init>
 80013da:	480d      	ldr	r0, [pc, #52]	; (8001410 <stdio_init+0x44>)
 80013dc:	f000 f81e 	bl	800141c <mutex_init>
 80013e0:	480c      	ldr	r0, [pc, #48]	; (8001414 <stdio_init+0x48>)
 80013e2:	f000 f81b 	bl	800141c <mutex_init>
 80013e6:	2408      	movs	r4, #8
 80013e8:	2020      	movs	r0, #32
 80013ea:	f7ff ff23 	bl	8001234 <putc_>
 80013ee:	3c01      	subs	r4, #1
 80013f0:	d1fa      	bne.n	80013e8 <stdio_init+0x1c>
 80013f2:	2420      	movs	r4, #32
 80013f4:	200a      	movs	r0, #10
 80013f6:	f7ff ff1d 	bl	8001234 <putc_>
 80013fa:	3c01      	subs	r4, #1
 80013fc:	d1fa      	bne.n	80013f4 <stdio_init+0x28>
 80013fe:	4806      	ldr	r0, [pc, #24]	; (8001418 <stdio_init+0x4c>)
 8001400:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 8001404:	f7ff bf90 	b.w	8001328 <printf_>
 8001408:	20000428 	.word	0x20000428
 800140c:	2000042c 	.word	0x2000042c
 8001410:	20000434 	.word	0x20000434
 8001414:	20000430 	.word	0x20000430
 8001418:	08002bdc 	.word	0x08002bdc

0800141c <mutex_init>:
 800141c:	b510      	push	{r4, lr}
 800141e:	4604      	mov	r4, r0
 8001420:	f7ff fe5a 	bl	80010d8 <sched_off>
 8001424:	2300      	movs	r3, #0
 8001426:	6023      	str	r3, [r4, #0]
 8001428:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 800142c:	f7ff be56 	b.w	80010dc <sched_on>

08001430 <mutex_lock>:
 8001430:	b513      	push	{r0, r1, r4, lr}
 8001432:	4604      	mov	r4, r0
 8001434:	f7ff fe50 	bl	80010d8 <sched_off>
 8001438:	6823      	ldr	r3, [r4, #0]
 800143a:	9301      	str	r3, [sp, #4]
 800143c:	f7ff fe4e 	bl	80010dc <sched_on>
 8001440:	9b01      	ldr	r3, [sp, #4]
 8001442:	b10b      	cbz	r3, 8001448 <mutex_lock+0x18>
 8001444:	f7ff fec2 	bl	80011cc <set_wait_state>
 8001448:	9b01      	ldr	r3, [sp, #4]
 800144a:	2b00      	cmp	r3, #0
 800144c:	d1f2      	bne.n	8001434 <mutex_lock+0x4>
 800144e:	f7ff fe43 	bl	80010d8 <sched_off>
 8001452:	6823      	ldr	r3, [r4, #0]
 8001454:	9301      	str	r3, [sp, #4]
 8001456:	9b01      	ldr	r3, [sp, #4]
 8001458:	2b00      	cmp	r3, #0
 800145a:	d1eb      	bne.n	8001434 <mutex_lock+0x4>
 800145c:	2301      	movs	r3, #1
 800145e:	6023      	str	r3, [r4, #0]
 8001460:	f7ff fe3c 	bl	80010dc <sched_on>
 8001464:	b002      	add	sp, #8
 8001466:	bd10      	pop	{r4, pc}

08001468 <mutex_unlock>:
 8001468:	b508      	push	{r3, lr}
 800146a:	f7ff ffd7 	bl	800141c <mutex_init>
 800146e:	f7ff fecf 	bl	8001210 <wake_up_threads>
 8001472:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8001476:	f7ff be33 	b.w	80010e0 <yield>
	...

0800147c <messages_init>:
 800147c:	4a0a      	ldr	r2, [pc, #40]	; (80014a8 <messages_init+0x2c>)
 800147e:	2300      	movs	r3, #0
 8001480:	b510      	push	{r4, lr}
 8001482:	6013      	str	r3, [r2, #0]
 8001484:	6053      	str	r3, [r2, #4]
 8001486:	6093      	str	r3, [r2, #8]
 8001488:	60d3      	str	r3, [r2, #12]
 800148a:	6113      	str	r3, [r2, #16]
 800148c:	6153      	str	r3, [r2, #20]
 800148e:	4c07      	ldr	r4, [pc, #28]	; (80014ac <messages_init+0x30>)
 8001490:	0118      	lsls	r0, r3, #4
 8001492:	1821      	adds	r1, r4, r0
 8001494:	3301      	adds	r3, #1
 8001496:	2200      	movs	r2, #0
 8001498:	2b04      	cmp	r3, #4
 800149a:	604a      	str	r2, [r1, #4]
 800149c:	5022      	str	r2, [r4, r0]
 800149e:	60ca      	str	r2, [r1, #12]
 80014a0:	608a      	str	r2, [r1, #8]
 80014a2:	d1f4      	bne.n	800148e <messages_init+0x12>
 80014a4:	bd10      	pop	{r4, pc}
 80014a6:	bf00      	nop
 80014a8:	20000438 	.word	0x20000438
 80014ac:	20000450 	.word	0x20000450

080014b0 <lib_os_init>:
 80014b0:	b508      	push	{r3, lr}
 80014b2:	f7ff fe69 	bl	8001188 <kernel_init>
 80014b6:	f7ff ffe1 	bl	800147c <messages_init>
 80014ba:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80014be:	f7ff bf85 	b.w	80013cc <stdio_init>
	...

080014c4 <main>:
 80014c4:	b508      	push	{r3, lr}
 80014c6:	f000 fa99 	bl	80019fc <lib_low_level_init>
 80014ca:	f7ff fff1 	bl	80014b0 <lib_os_init>
 80014ce:	4905      	ldr	r1, [pc, #20]	; (80014e4 <main+0x20>)
 80014d0:	4805      	ldr	r0, [pc, #20]	; (80014e8 <main+0x24>)
 80014d2:	f44f 7200 	mov.w	r2, #512	; 0x200
 80014d6:	2306      	movs	r3, #6
 80014d8:	f7ff fe16 	bl	8001108 <create_thread>
 80014dc:	f7ff fe0e 	bl	80010fc <kernel_start>
 80014e0:	2000      	movs	r0, #0
 80014e2:	bd08      	pop	{r3, pc}
 80014e4:	20000a90 	.word	0x20000a90
 80014e8:	08001945 	.word	0x08001945

080014ec <abort_error_>:
 80014ec:	b570      	push	{r4, r5, r6, lr}
 80014ee:	4605      	mov	r5, r0
 80014f0:	460e      	mov	r6, r1
 80014f2:	480d      	ldr	r0, [pc, #52]	; (8001528 <abort_error_+0x3c>)
 80014f4:	4629      	mov	r1, r5
 80014f6:	4632      	mov	r2, r6
 80014f8:	f7ff ff16 	bl	8001328 <printf_>
 80014fc:	2408      	movs	r4, #8
 80014fe:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 8001502:	f001 f8e1 	bl	80026c8 <led_on>
 8001506:	201e      	movs	r0, #30
 8001508:	f000 fbac 	bl	8001c64 <timer_delay_ms>
 800150c:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 8001510:	f001 f8f0 	bl	80026f4 <led_off>
 8001514:	2046      	movs	r0, #70	; 0x46
 8001516:	f000 fba5 	bl	8001c64 <timer_delay_ms>
 800151a:	3c01      	subs	r4, #1
 800151c:	d1ef      	bne.n	80014fe <abort_error_+0x12>
 800151e:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 8001522:	f000 fb9f 	bl	8001c64 <timer_delay_ms>
 8001526:	e7e4      	b.n	80014f2 <abort_error_+0x6>
 8001528:	08002bed 	.word	0x08002bed

0800152c <charging_test_go_straight_until_line>:
 800152c:	b570      	push	{r4, r5, r6, lr}
 800152e:	4606      	mov	r6, r0
 8001530:	f7ff fa06 	bl	8000940 <rgb_get_line_position>
 8001534:	4b11      	ldr	r3, [pc, #68]	; (800157c <charging_test_go_straight_until_line+0x50>)
 8001536:	220a      	movs	r2, #10
 8001538:	605a      	str	r2, [r3, #4]
 800153a:	461d      	mov	r5, r3
 800153c:	601a      	str	r2, [r3, #0]
 800153e:	2e03      	cmp	r6, #3
 8001540:	d812      	bhi.n	8001568 <charging_test_go_straight_until_line+0x3c>
 8001542:	e8df f006 	tbb	[pc, r6]
 8001546:	0502      	.short	0x0502
 8001548:	0b08      	.short	0x0b08
 800154a:	4b0d      	ldr	r3, [pc, #52]	; (8001580 <charging_test_go_straight_until_line+0x54>)
 800154c:	7c1c      	ldrb	r4, [r3, #16]
 800154e:	e007      	b.n	8001560 <charging_test_go_straight_until_line+0x34>
 8001550:	4b0b      	ldr	r3, [pc, #44]	; (8001580 <charging_test_go_straight_until_line+0x54>)
 8001552:	7c5c      	ldrb	r4, [r3, #17]
 8001554:	e004      	b.n	8001560 <charging_test_go_straight_until_line+0x34>
 8001556:	4b0a      	ldr	r3, [pc, #40]	; (8001580 <charging_test_go_straight_until_line+0x54>)
 8001558:	7c9c      	ldrb	r4, [r3, #18]
 800155a:	e001      	b.n	8001560 <charging_test_go_straight_until_line+0x34>
 800155c:	4b08      	ldr	r3, [pc, #32]	; (8001580 <charging_test_go_straight_until_line+0x54>)
 800155e:	7cdc      	ldrb	r4, [r3, #19]
 8001560:	fab4 f484 	clz	r4, r4
 8001564:	0964      	lsrs	r4, r4, #5
 8001566:	e000      	b.n	800156a <charging_test_go_straight_until_line+0x3e>
 8001568:	2401      	movs	r4, #1
 800156a:	200a      	movs	r0, #10
 800156c:	f000 fb7a 	bl	8001c64 <timer_delay_ms>
 8001570:	2c00      	cmp	r4, #0
 8001572:	d1dd      	bne.n	8001530 <charging_test_go_straight_until_line+0x4>
 8001574:	606c      	str	r4, [r5, #4]
 8001576:	602c      	str	r4, [r5, #0]
 8001578:	bd70      	pop	{r4, r5, r6, pc}
 800157a:	bf00      	nop
 800157c:	200000e4 	.word	0x200000e4
 8001580:	200000ec 	.word	0x200000ec

08001584 <slightTurn>:
 8001584:	2a02      	cmp	r2, #2
 8001586:	b510      	push	{r4, lr}
 8001588:	d105      	bne.n	8001596 <slightTurn+0x12>
 800158a:	4c0a      	ldr	r4, [pc, #40]	; (80015b4 <slightTurn+0x30>)
 800158c:	6021      	str	r1, [r4, #0]
 800158e:	fb91 f1f2 	sdiv	r1, r1, r2
 8001592:	4249      	negs	r1, r1
 8001594:	e007      	b.n	80015a6 <slightTurn+0x22>
 8001596:	2a01      	cmp	r2, #1
 8001598:	d10b      	bne.n	80015b2 <slightTurn+0x2e>
 800159a:	4c06      	ldr	r4, [pc, #24]	; (80015b4 <slightTurn+0x30>)
 800159c:	2302      	movs	r3, #2
 800159e:	fb91 f3f3 	sdiv	r3, r1, r3
 80015a2:	425b      	negs	r3, r3
 80015a4:	6023      	str	r3, [r4, #0]
 80015a6:	6061      	str	r1, [r4, #4]
 80015a8:	f000 fb5c 	bl	8001c64 <timer_delay_ms>
 80015ac:	2300      	movs	r3, #0
 80015ae:	6023      	str	r3, [r4, #0]
 80015b0:	6063      	str	r3, [r4, #4]
 80015b2:	bd10      	pop	{r4, pc}
 80015b4:	200000e4 	.word	0x200000e4

080015b8 <line_follower_until_color>:
 80015b8:	b570      	push	{r4, r5, r6, lr}
 80015ba:	ed2d 8b06 	vpush	{d8-d10}
 80015be:	eddf 8a46 	vldr	s17, [pc, #280]	; 80016d8 <line_follower_until_color+0x120>
 80015c2:	4604      	mov	r4, r0
 80015c4:	460d      	mov	r5, r1
 80015c6:	eef0 9a68 	vmov.f32	s19, s17
 80015ca:	eeb0 aa68 	vmov.f32	s20, s17
 80015ce:	f7ff f9b7 	bl	8000940 <rgb_get_line_position>
 80015d2:	4e42      	ldr	r6, [pc, #264]	; (80016dc <line_follower_until_color+0x124>)
 80015d4:	2d03      	cmp	r5, #3
 80015d6:	d817      	bhi.n	8001608 <line_follower_until_color+0x50>
 80015d8:	e8df f005 	tbb	[pc, r5]
 80015dc:	0b080502 	.word	0x0b080502
 80015e0:	4b3f      	ldr	r3, [pc, #252]	; (80016e0 <line_follower_until_color+0x128>)
 80015e2:	7c1b      	ldrb	r3, [r3, #16]
 80015e4:	e007      	b.n	80015f6 <line_follower_until_color+0x3e>
 80015e6:	4b3e      	ldr	r3, [pc, #248]	; (80016e0 <line_follower_until_color+0x128>)
 80015e8:	7c5b      	ldrb	r3, [r3, #17]
 80015ea:	e004      	b.n	80015f6 <line_follower_until_color+0x3e>
 80015ec:	4b3c      	ldr	r3, [pc, #240]	; (80016e0 <line_follower_until_color+0x128>)
 80015ee:	7c9b      	ldrb	r3, [r3, #18]
 80015f0:	e001      	b.n	80015f6 <line_follower_until_color+0x3e>
 80015f2:	4b3b      	ldr	r3, [pc, #236]	; (80016e0 <line_follower_until_color+0x128>)
 80015f4:	7cdb      	ldrb	r3, [r3, #19]
 80015f6:	fab3 f383 	clz	r3, r3
 80015fa:	095b      	lsrs	r3, r3, #5
 80015fc:	b923      	cbnz	r3, 8001608 <line_follower_until_color+0x50>
 80015fe:	ecbd 8b06 	vpop	{d8-d10}
 8001602:	6033      	str	r3, [r6, #0]
 8001604:	6073      	str	r3, [r6, #4]
 8001606:	bd70      	pop	{r4, r5, r6, pc}
 8001608:	2c03      	cmp	r4, #3
 800160a:	d81b      	bhi.n	8001644 <line_follower_until_color+0x8c>
 800160c:	e8df f004 	tbb	[pc, r4]
 8001610:	0e0a0602 	.word	0x0e0a0602
 8001614:	4b32      	ldr	r3, [pc, #200]	; (80016e0 <line_follower_until_color+0x128>)
 8001616:	ed93 8a00 	vldr	s16, [r3]
 800161a:	e00a      	b.n	8001632 <line_follower_until_color+0x7a>
 800161c:	4b30      	ldr	r3, [pc, #192]	; (80016e0 <line_follower_until_color+0x128>)
 800161e:	ed93 8a01 	vldr	s16, [r3, #4]
 8001622:	e006      	b.n	8001632 <line_follower_until_color+0x7a>
 8001624:	4b2e      	ldr	r3, [pc, #184]	; (80016e0 <line_follower_until_color+0x128>)
 8001626:	ed93 8a02 	vldr	s16, [r3, #8]
 800162a:	e002      	b.n	8001632 <line_follower_until_color+0x7a>
 800162c:	4b2c      	ldr	r3, [pc, #176]	; (80016e0 <line_follower_until_color+0x128>)
 800162e:	ed93 8a03 	vldr	s16, [r3, #12]
 8001632:	eddf 7a2c 	vldr	s15, [pc, #176]	; 80016e4 <line_follower_until_color+0x12c>
 8001636:	eeb8 8ac8 	vcvt.f32.s32	s16, s16
 800163a:	ee88 8a27 	vdiv.f32	s16, s16, s15
 800163e:	ee3a 8a48 	vsub.f32	s16, s20, s16
 8001642:	e001      	b.n	8001648 <line_follower_until_color+0x90>
 8001644:	eeb0 8a68 	vmov.f32	s16, s17
 8001648:	ed9f 9a27 	vldr	s18, [pc, #156]	; 80016e8 <line_follower_until_color+0x130>
 800164c:	eeb4 8ac9 	vcmpe.f32	s16, s18
 8001650:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 8001654:	dc09      	bgt.n	800166a <line_follower_until_color+0xb2>
 8001656:	eddf 7a25 	vldr	s15, [pc, #148]	; 80016ec <line_follower_until_color+0x134>
 800165a:	eeb4 8a67 	vcmp.f32	s16, s15
 800165e:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 8001662:	bf48      	it	mi
 8001664:	eeb0 8a67 	vmovmi.f32	s16, s15
 8001668:	e001      	b.n	800166e <line_follower_until_color+0xb6>
 800166a:	eeb0 8a49 	vmov.f32	s16, s18
 800166e:	ee78 7a68 	vsub.f32	s15, s16, s17
 8001672:	eddf 8a1f 	vldr	s17, [pc, #124]	; 80016f0 <line_follower_until_color+0x138>
 8001676:	ee67 8aa8 	vmul.f32	s17, s15, s17
 800167a:	eddf 7a1e 	vldr	s15, [pc, #120]	; 80016f4 <line_follower_until_color+0x13c>
 800167e:	ee18 0a10 	vmov	r0, s16
 8001682:	ee48 8a27 	vmla.f32	s17, s16, s15
 8001686:	f7fe fd7f 	bl	8000188 <m_abs>
 800168a:	ee07 0a90 	vmov	s15, r0
 800168e:	ee39 9a67 	vsub.f32	s18, s18, s15
 8001692:	eddf 7a19 	vldr	s15, [pc, #100]	; 80016f8 <line_follower_until_color+0x140>
 8001696:	ee69 7a27 	vmul.f32	s15, s18, s15
 800169a:	ee17 0a90 	vmov	r0, s15
 800169e:	eddf 7a17 	vldr	s15, [pc, #92]	; 80016fc <line_follower_until_color+0x144>
 80016a2:	ee79 7aa7 	vadd.f32	s15, s19, s15
 80016a6:	ee17 1a90 	vmov	r1, s15
 80016aa:	f7fe fd79 	bl	80001a0 <m_min>
 80016ae:	ee09 0a90 	vmov	s19, r0
 80016b2:	ee79 7aa8 	vadd.f32	s15, s19, s17
 80016b6:	ee79 8ae8 	vsub.f32	s17, s19, s17
 80016ba:	eefd 7ae7 	vcvt.s32.f32	s15, s15
 80016be:	eefd 8ae8 	vcvt.s32.f32	s17, s17
 80016c2:	200a      	movs	r0, #10
 80016c4:	edc6 7a00 	vstr	s15, [r6]
 80016c8:	edc6 8a01 	vstr	s17, [r6, #4]
 80016cc:	f000 faca 	bl	8001c64 <timer_delay_ms>
 80016d0:	eef0 8a48 	vmov.f32	s17, s16
 80016d4:	e77b      	b.n	80015ce <line_follower_until_color+0x16>
 80016d6:	bf00      	nop
 80016d8:	00000000 	.word	0x00000000
 80016dc:	200000e4 	.word	0x200000e4
 80016e0:	200000ec 	.word	0x200000ec
 80016e4:	428c0000 	.word	0x428c0000
 80016e8:	3f800000 	.word	0x3f800000
 80016ec:	bf800000 	.word	0xbf800000
 80016f0:	42c80000 	.word	0x42c80000
 80016f4:	42200000 	.word	0x42200000
 80016f8:	40a00000 	.word	0x40a00000
 80016fc:	3e19999a 	.word	0x3e19999a

08001700 <line_follower_with_charging>:
 8001700:	e92d 43f7 	stmdb	sp!, {r0, r1, r2, r4, r5, r6, r7, r8, r9, lr}
 8001704:	9e0a      	ldr	r6, [sp, #40]	; 0x28
 8001706:	460f      	mov	r7, r1
 8001708:	4690      	mov	r8, r2
 800170a:	4699      	mov	r9, r3
 800170c:	2400      	movs	r4, #0
 800170e:	2c06      	cmp	r4, #6
 8001710:	d8fd      	bhi.n	800170e <line_follower_with_charging+0xe>
 8001712:	e8df f004 	tbb	[pc, r4]
 8001716:	1004      	.short	0x1004
 8001718:	4f384922 	.word	0x4f384922
 800171c:	68          	.byte	0x68
 800171d:	00          	.byte	0x00
 800171e:	f7fe fd4d 	bl	80001bc <getBatteryVoltage>
 8001722:	4b39      	ldr	r3, [pc, #228]	; (8001808 <line_follower_with_charging+0x108>)
 8001724:	4540      	cmp	r0, r8
 8001726:	f04f 0200 	mov.w	r2, #0
 800172a:	601a      	str	r2, [r3, #0]
 800172c:	bf2c      	ite	cs
 800172e:	2400      	movcs	r4, #0
 8001730:	2401      	movcc	r4, #1
 8001732:	605a      	str	r2, [r3, #4]
 8001734:	e7eb      	b.n	800170e <line_follower_with_charging+0xe>
 8001736:	4935      	ldr	r1, [pc, #212]	; (800180c <line_follower_with_charging+0x10c>)
 8001738:	4a35      	ldr	r2, [pc, #212]	; (8001810 <line_follower_with_charging+0x110>)
 800173a:	4836      	ldr	r0, [pc, #216]	; (8001814 <line_follower_with_charging+0x114>)
 800173c:	2300      	movs	r3, #0
 800173e:	700b      	strb	r3, [r1, #0]
 8001740:	2301      	movs	r3, #1
 8001742:	7013      	strb	r3, [r2, #0]
 8001744:	e88d 000a 	stmia.w	sp, {r1, r3}
 8001748:	f643 2199 	movw	r1, #15001	; 0x3a99
 800174c:	f7ff fade 	bl	8000d0c <charging_send_message>
 8001750:	2064      	movs	r0, #100	; 0x64
 8001752:	f000 fa87 	bl	8001c64 <timer_delay_ms>
 8001756:	2402      	movs	r4, #2
 8001758:	e7d9      	b.n	800170e <line_follower_with_charging+0xe>
 800175a:	4b2c      	ldr	r3, [pc, #176]	; (800180c <line_follower_with_charging+0x10c>)
 800175c:	781b      	ldrb	r3, [r3, #0]
 800175e:	b913      	cbnz	r3, 8001766 <line_follower_with_charging+0x66>
 8001760:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 8001764:	e00b      	b.n	800177e <line_follower_with_charging+0x7e>
 8001766:	2b01      	cmp	r3, #1
 8001768:	d101      	bne.n	800176e <line_follower_with_charging+0x6e>
 800176a:	2403      	movs	r4, #3
 800176c:	e7cf      	b.n	800170e <line_follower_with_charging+0xe>
 800176e:	2b02      	cmp	r3, #2
 8001770:	d101      	bne.n	8001776 <line_follower_with_charging+0x76>
 8001772:	2404      	movs	r4, #4
 8001774:	e7cb      	b.n	800170e <line_follower_with_charging+0xe>
 8001776:	2b03      	cmp	r3, #3
 8001778:	d1f2      	bne.n	8001760 <line_follower_with_charging+0x60>
 800177a:	f241 3088 	movw	r0, #5000	; 0x1388
 800177e:	f000 fa71 	bl	8001c64 <timer_delay_ms>
 8001782:	2401      	movs	r4, #1
 8001784:	e7c3      	b.n	800170e <line_follower_with_charging+0xe>
 8001786:	4638      	mov	r0, r7
 8001788:	f7ff fed0 	bl	800152c <charging_test_go_straight_until_line>
 800178c:	4b22      	ldr	r3, [pc, #136]	; (8001818 <line_follower_with_charging+0x118>)
 800178e:	88db      	ldrh	r3, [r3, #6]
 8001790:	b21b      	sxth	r3, r3
 8001792:	2b28      	cmp	r3, #40	; 0x28
 8001794:	dd08      	ble.n	80017a8 <line_follower_with_charging+0xa8>
 8001796:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 800179a:	2114      	movs	r1, #20
 800179c:	2201      	movs	r2, #1
 800179e:	f7ff fef1 	bl	8001584 <slightTurn>
 80017a2:	2001      	movs	r0, #1
 80017a4:	f7ff fec2 	bl	800152c <charging_test_go_straight_until_line>
 80017a8:	4638      	mov	r0, r7
 80017aa:	2100      	movs	r1, #0
 80017ac:	f7ff ff04 	bl	80015b8 <line_follower_until_color>
 80017b0:	2405      	movs	r4, #5
 80017b2:	e7ac      	b.n	800170e <line_follower_with_charging+0xe>
 80017b4:	4b14      	ldr	r3, [pc, #80]	; (8001808 <line_follower_with_charging+0x108>)
 80017b6:	2200      	movs	r2, #0
 80017b8:	605a      	str	r2, [r3, #4]
 80017ba:	601a      	str	r2, [r3, #0]
 80017bc:	f7fe fd1c 	bl	80001f8 <getChargingVoltage>
 80017c0:	42b0      	cmp	r0, r6
 80017c2:	d3a4      	bcc.n	800170e <line_follower_with_charging+0xe>
 80017c4:	4a12      	ldr	r2, [pc, #72]	; (8001810 <line_follower_with_charging+0x110>)
 80017c6:	4813      	ldr	r0, [pc, #76]	; (8001814 <line_follower_with_charging+0x114>)
 80017c8:	2302      	movs	r3, #2
 80017ca:	7013      	strb	r3, [r2, #0]
 80017cc:	4b0f      	ldr	r3, [pc, #60]	; (800180c <line_follower_with_charging+0x10c>)
 80017ce:	9300      	str	r3, [sp, #0]
 80017d0:	2301      	movs	r3, #1
 80017d2:	9301      	str	r3, [sp, #4]
 80017d4:	f643 2199 	movw	r1, #15001	; 0x3a99
 80017d8:	f7ff fa98 	bl	8000d0c <charging_send_message>
 80017dc:	2064      	movs	r0, #100	; 0x64
 80017de:	f000 fa41 	bl	8001c64 <timer_delay_ms>
 80017e2:	2406      	movs	r4, #6
 80017e4:	e793      	b.n	800170e <line_follower_with_charging+0xe>
 80017e6:	f7fe fce9 	bl	80001bc <getBatteryVoltage>
 80017ea:	4548      	cmp	r0, r9
 80017ec:	d98f      	bls.n	800170e <line_follower_with_charging+0xe>
 80017ee:	4d06      	ldr	r5, [pc, #24]	; (8001808 <line_follower_with_charging+0x108>)
 80017f0:	f06f 0309 	mvn.w	r3, #9
 80017f4:	2400      	movs	r4, #0
 80017f6:	f640 30b8 	movw	r0, #3000	; 0xbb8
 80017fa:	602b      	str	r3, [r5, #0]
 80017fc:	606b      	str	r3, [r5, #4]
 80017fe:	f000 fa31 	bl	8001c64 <timer_delay_ms>
 8001802:	602c      	str	r4, [r5, #0]
 8001804:	606c      	str	r4, [r5, #4]
 8001806:	e782      	b.n	800170e <line_follower_with_charging+0xe>
 8001808:	200000e4 	.word	0x200000e4
 800180c:	20000104 	.word	0x20000104
 8001810:	20000184 	.word	0x20000184
 8001814:	08002bcd 	.word	0x08002bcd
 8001818:	20000064 	.word	0x20000064

0800181c <device_sleep>:
 800181c:	4b01      	ldr	r3, [pc, #4]	; (8001824 <device_sleep+0x8>)
 800181e:	22ff      	movs	r2, #255	; 0xff
 8001820:	701a      	strb	r2, [r3, #0]
 8001822:	4770      	bx	lr
 8001824:	20000030 	.word	0x20000030

08001828 <device_wake_up>:
 8001828:	4b01      	ldr	r3, [pc, #4]	; (8001830 <device_wake_up+0x8>)
 800182a:	2200      	movs	r2, #0
 800182c:	701a      	strb	r2, [r3, #0]
 800182e:	4770      	bx	lr
 8001830:	20000030 	.word	0x20000030

08001834 <device_i2c_thread>:
 8001834:	b538      	push	{r3, r4, r5, lr}
 8001836:	2000      	movs	r0, #0
 8001838:	210a      	movs	r1, #10
 800183a:	f000 fa23 	bl	8001c84 <event_timer_set_period>
 800183e:	2501      	movs	r5, #1
 8001840:	2400      	movs	r4, #0
 8001842:	2c01      	cmp	r4, #1
 8001844:	d016      	beq.n	8001874 <device_i2c_thread+0x40>
 8001846:	d30e      	bcc.n	8001866 <device_i2c_thread+0x32>
 8001848:	2c02      	cmp	r4, #2
 800184a:	d1fa      	bne.n	8001842 <device_i2c_thread+0xe>
 800184c:	f7fe fdff 	bl	800044e <lsm9ds0_uninit>
 8001850:	f7ff fb38 	bl	8000ec4 <motors_uninit>
 8001854:	2064      	movs	r0, #100	; 0x64
 8001856:	f000 fa05 	bl	8001c64 <timer_delay_ms>
 800185a:	4b0d      	ldr	r3, [pc, #52]	; (8001890 <device_i2c_thread+0x5c>)
 800185c:	781b      	ldrb	r3, [r3, #0]
 800185e:	2b00      	cmp	r3, #0
 8001860:	bf08      	it	eq
 8001862:	2400      	moveq	r4, #0
 8001864:	e7ed      	b.n	8001842 <device_i2c_thread+0xe>
 8001866:	f7ff fbc1 	bl	8000fec <motors_init>
 800186a:	4628      	mov	r0, r5
 800186c:	f7fe fec4 	bl	80005f8 <lsm9ds0_init>
 8001870:	2500      	movs	r5, #0
 8001872:	2401      	movs	r4, #1
 8001874:	2000      	movs	r0, #0
 8001876:	f000 fa1d 	bl	8001cb4 <event_timer_wait>
 800187a:	f7fe fdfb 	bl	8000474 <lsm9ds0_read>
 800187e:	f7ff fb2f 	bl	8000ee0 <motors_update>
 8001882:	4b03      	ldr	r3, [pc, #12]	; (8001890 <device_i2c_thread+0x5c>)
 8001884:	781b      	ldrb	r3, [r3, #0]
 8001886:	2b00      	cmp	r3, #0
 8001888:	bf18      	it	ne
 800188a:	2402      	movne	r4, #2
 800188c:	e7d9      	b.n	8001842 <device_i2c_thread+0xe>
 800188e:	bf00      	nop
 8001890:	20000030 	.word	0x20000030

08001894 <device_rgb_sensors_thread>:
 8001894:	b510      	push	{r4, lr}
 8001896:	2001      	movs	r0, #1
 8001898:	210a      	movs	r1, #10
 800189a:	f000 f9f3 	bl	8001c84 <event_timer_set_period>
 800189e:	2400      	movs	r4, #0
 80018a0:	2001      	movs	r0, #1
 80018a2:	f000 fa07 	bl	8001cb4 <event_timer_wait>
 80018a6:	2c01      	cmp	r4, #1
 80018a8:	d019      	beq.n	80018de <device_rgb_sensors_thread+0x4a>
 80018aa:	d30c      	bcc.n	80018c6 <device_rgb_sensors_thread+0x32>
 80018ac:	2c02      	cmp	r4, #2
 80018ae:	d1f7      	bne.n	80018a0 <device_rgb_sensors_thread+0xc>
 80018b0:	f7fe fef8 	bl	80006a4 <rgb_sensor_uninit>
 80018b4:	2064      	movs	r0, #100	; 0x64
 80018b6:	f000 f9d5 	bl	8001c64 <timer_delay_ms>
 80018ba:	4b0d      	ldr	r3, [pc, #52]	; (80018f0 <device_rgb_sensors_thread+0x5c>)
 80018bc:	781b      	ldrb	r3, [r3, #0]
 80018be:	2b00      	cmp	r3, #0
 80018c0:	bf08      	it	eq
 80018c2:	2400      	moveq	r4, #0
 80018c4:	e7ec      	b.n	80018a0 <device_rgb_sensors_thread+0xc>
 80018c6:	f7fe ffe3 	bl	8000890 <rgb_sensor_init>
 80018ca:	4604      	mov	r4, r0
 80018cc:	b128      	cbz	r0, 80018da <device_rgb_sensors_thread+0x46>
 80018ce:	f7fe fee9 	bl	80006a4 <rgb_sensor_uninit>
 80018d2:	2001      	movs	r0, #1
 80018d4:	4621      	mov	r1, r4
 80018d6:	f7ff fe09 	bl	80014ec <abort_error_>
 80018da:	2401      	movs	r4, #1
 80018dc:	e7e0      	b.n	80018a0 <device_rgb_sensors_thread+0xc>
 80018de:	f7fe feed 	bl	80006bc <rgb_sensor_read>
 80018e2:	4b03      	ldr	r3, [pc, #12]	; (80018f0 <device_rgb_sensors_thread+0x5c>)
 80018e4:	781b      	ldrb	r3, [r3, #0]
 80018e6:	2b00      	cmp	r3, #0
 80018e8:	d0f7      	beq.n	80018da <device_rgb_sensors_thread+0x46>
 80018ea:	2402      	movs	r4, #2
 80018ec:	e7d8      	b.n	80018a0 <device_rgb_sensors_thread+0xc>
 80018ee:	bf00      	nop
 80018f0:	20000030 	.word	0x20000030

080018f4 <device_wifi_thread>:
 80018f4:	b510      	push	{r4, lr}
 80018f6:	2400      	movs	r4, #0
 80018f8:	b164      	cbz	r4, 8001914 <device_wifi_thread+0x20>
 80018fa:	2c02      	cmp	r4, #2
 80018fc:	d1fc      	bne.n	80018f8 <device_wifi_thread+0x4>
 80018fe:	f7ff f9d9 	bl	8000cb4 <esp8266_uninit>
 8001902:	2064      	movs	r0, #100	; 0x64
 8001904:	f000 f9ae 	bl	8001c64 <timer_delay_ms>
 8001908:	4b0d      	ldr	r3, [pc, #52]	; (8001940 <device_wifi_thread+0x4c>)
 800190a:	781b      	ldrb	r3, [r3, #0]
 800190c:	2b00      	cmp	r3, #0
 800190e:	bf08      	it	eq
 8001910:	2400      	moveq	r4, #0
 8001912:	e7f1      	b.n	80018f8 <device_wifi_thread+0x4>
 8001914:	2001      	movs	r0, #1
 8001916:	f000 fed7 	bl	80026c8 <led_on>
 800191a:	f7ff faa5 	bl	8000e68 <tcp_init>
 800191e:	4620      	mov	r0, r4
 8001920:	f7ff f976 	bl	8000c10 <esp8266_init>
 8001924:	4604      	mov	r4, r0
 8001926:	b128      	cbz	r0, 8001934 <device_wifi_thread+0x40>
 8001928:	f7ff f9c4 	bl	8000cb4 <esp8266_uninit>
 800192c:	2003      	movs	r0, #3
 800192e:	4621      	mov	r1, r4
 8001930:	f7ff fddc 	bl	80014ec <abort_error_>
 8001934:	2064      	movs	r0, #100	; 0x64
 8001936:	f000 f995 	bl	8001c64 <timer_delay_ms>
 800193a:	2401      	movs	r4, #1
 800193c:	e7dc      	b.n	80018f8 <device_wifi_thread+0x4>
 800193e:	bf00      	nop
 8001940:	20000030 	.word	0x20000030

08001944 <main_thread>:
 8001944:	b507      	push	{r0, r1, r2, lr}
 8001946:	4826      	ldr	r0, [pc, #152]	; (80019e0 <main_thread+0x9c>)
 8001948:	f7ff fcee 	bl	8001328 <printf_>
 800194c:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 8001950:	f000 f988 	bl	8001c64 <timer_delay_ms>
 8001954:	f7ff ff68 	bl	8001828 <device_wake_up>
 8001958:	4922      	ldr	r1, [pc, #136]	; (80019e4 <main_thread+0xa0>)
 800195a:	4823      	ldr	r0, [pc, #140]	; (80019e8 <main_thread+0xa4>)
 800195c:	f44f 7200 	mov.w	r2, #512	; 0x200
 8001960:	2306      	movs	r3, #6
 8001962:	f7ff fbd1 	bl	8001108 <create_thread>
 8001966:	4921      	ldr	r1, [pc, #132]	; (80019ec <main_thread+0xa8>)
 8001968:	4821      	ldr	r0, [pc, #132]	; (80019f0 <main_thread+0xac>)
 800196a:	f44f 7200 	mov.w	r2, #512	; 0x200
 800196e:	2306      	movs	r3, #6
 8001970:	f7ff fbca 	bl	8001108 <create_thread>
 8001974:	491f      	ldr	r1, [pc, #124]	; (80019f4 <main_thread+0xb0>)
 8001976:	4820      	ldr	r0, [pc, #128]	; (80019f8 <main_thread+0xb4>)
 8001978:	f44f 7200 	mov.w	r2, #512	; 0x200
 800197c:	2306      	movs	r3, #6
 800197e:	f7ff fbc3 	bl	8001108 <create_thread>
 8001982:	20c8      	movs	r0, #200	; 0xc8
 8001984:	f000 f96e 	bl	8001c64 <timer_delay_ms>
 8001988:	f7ff f88a 	bl	8000aa0 <rgb_set_background>
 800198c:	f000 ff2e 	bl	80027ec <get_key>
 8001990:	b980      	cbnz	r0, 80019b4 <main_thread+0x70>
 8001992:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 8001996:	f000 fe97 	bl	80026c8 <led_on>
 800199a:	2064      	movs	r0, #100	; 0x64
 800199c:	f000 f962 	bl	8001c64 <timer_delay_ms>
 80019a0:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 80019a4:	f000 fea6 	bl	80026f4 <led_off>
 80019a8:	20c8      	movs	r0, #200	; 0xc8
 80019aa:	f000 f95b 	bl	8001c64 <timer_delay_ms>
 80019ae:	f7ff ff35 	bl	800181c <device_sleep>
 80019b2:	e7eb      	b.n	800198c <main_thread+0x48>
 80019b4:	f7ff ff38 	bl	8001828 <device_wake_up>
 80019b8:	20c8      	movs	r0, #200	; 0xc8
 80019ba:	f000 f953 	bl	8001c64 <timer_delay_ms>
 80019be:	f241 3288 	movw	r2, #5000	; 0x1388
 80019c2:	2001      	movs	r0, #1
 80019c4:	9200      	str	r2, [sp, #0]
 80019c6:	4601      	mov	r1, r0
 80019c8:	f241 0368 	movw	r3, #4200	; 0x1068
 80019cc:	f7ff fe98 	bl	8001700 <line_follower_with_charging>
 80019d0:	f000 ff0c 	bl	80027ec <get_key>
 80019d4:	2800      	cmp	r0, #0
 80019d6:	d1d9      	bne.n	800198c <main_thread+0x48>
 80019d8:	f7fe ffb2 	bl	8000940 <rgb_get_line_position>
 80019dc:	e7f8      	b.n	80019d0 <main_thread+0x8c>
 80019de:	bf00      	nop
 80019e0:	08002c65 	.word	0x08002c65
 80019e4:	20000690 	.word	0x20000690
 80019e8:	08001895 	.word	0x08001895
 80019ec:	20000490 	.word	0x20000490
 80019f0:	08001835 	.word	0x08001835
 80019f4:	20000890 	.word	0x20000890
 80019f8:	080018f5 	.word	0x080018f5

080019fc <lib_low_level_init>:
 80019fc:	b508      	push	{r3, lr}
 80019fe:	f000 fde3 	bl	80025c8 <sytem_clock_init>
 8001a02:	f000 fe8d 	bl	8002720 <gpio_init>
 8001a06:	f000 fcf9 	bl	80023fc <uart_init>
 8001a0a:	f000 f8a5 	bl	8001b58 <timer_init>
 8001a0e:	f000 ffaf 	bl	8002970 <i2c_0_init>
 8001a12:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8001a16:	f000 bb0f 	b.w	8002038 <adc_init>
	...

08001a1c <NVIC_Init>:
 8001a1c:	b510      	push	{r4, lr}
 8001a1e:	bf00      	nop
 8001a20:	bf00      	nop
 8001a22:	bf00      	nop
 8001a24:	78c2      	ldrb	r2, [r0, #3]
 8001a26:	7803      	ldrb	r3, [r0, #0]
 8001a28:	b312      	cbz	r2, 8001a70 <NVIC_Init+0x54>
 8001a2a:	4a17      	ldr	r2, [pc, #92]	; (8001a88 <NVIC_Init+0x6c>)
 8001a2c:	68d1      	ldr	r1, [r2, #12]
 8001a2e:	7842      	ldrb	r2, [r0, #1]
 8001a30:	43c9      	mvns	r1, r1
 8001a32:	f3c1 2102 	ubfx	r1, r1, #8, #3
 8001a36:	f1c1 0404 	rsb	r4, r1, #4
 8001a3a:	b2e4      	uxtb	r4, r4
 8001a3c:	40a2      	lsls	r2, r4
 8001a3e:	b2d4      	uxtb	r4, r2
 8001a40:	220f      	movs	r2, #15
 8001a42:	410a      	asrs	r2, r1
 8001a44:	7881      	ldrb	r1, [r0, #2]
 8001a46:	400a      	ands	r2, r1
 8001a48:	4322      	orrs	r2, r4
 8001a4a:	f103 4360 	add.w	r3, r3, #3758096384	; 0xe0000000
 8001a4e:	f503 4361 	add.w	r3, r3, #57600	; 0xe100
 8001a52:	0112      	lsls	r2, r2, #4
 8001a54:	b2d2      	uxtb	r2, r2
 8001a56:	f883 2300 	strb.w	r2, [r3, #768]	; 0x300
 8001a5a:	7803      	ldrb	r3, [r0, #0]
 8001a5c:	2201      	movs	r2, #1
 8001a5e:	0959      	lsrs	r1, r3, #5
 8001a60:	f003 031f 	and.w	r3, r3, #31
 8001a64:	fa02 f303 	lsl.w	r3, r2, r3
 8001a68:	4a08      	ldr	r2, [pc, #32]	; (8001a8c <NVIC_Init+0x70>)
 8001a6a:	f842 3021 	str.w	r3, [r2, r1, lsl #2]
 8001a6e:	bd10      	pop	{r4, pc}
 8001a70:	095a      	lsrs	r2, r3, #5
 8001a72:	2101      	movs	r1, #1
 8001a74:	f003 031f 	and.w	r3, r3, #31
 8001a78:	4099      	lsls	r1, r3
 8001a7a:	f102 0320 	add.w	r3, r2, #32
 8001a7e:	4a03      	ldr	r2, [pc, #12]	; (8001a8c <NVIC_Init+0x70>)
 8001a80:	f842 1023 	str.w	r1, [r2, r3, lsl #2]
 8001a84:	bd10      	pop	{r4, pc}
 8001a86:	bf00      	nop
 8001a88:	e000ed00 	.word	0xe000ed00
 8001a8c:	e000e100 	.word	0xe000e100

08001a90 <TIM_TimeBaseInit>:
 8001a90:	bf00      	nop
 8001a92:	bf00      	nop
 8001a94:	bf00      	nop
 8001a96:	4a24      	ldr	r2, [pc, #144]	; (8001b28 <TIM_TimeBaseInit+0x98>)
 8001a98:	8803      	ldrh	r3, [r0, #0]
 8001a9a:	4290      	cmp	r0, r2
 8001a9c:	b29b      	uxth	r3, r3
 8001a9e:	d012      	beq.n	8001ac6 <TIM_TimeBaseInit+0x36>
 8001aa0:	f502 6200 	add.w	r2, r2, #2048	; 0x800
 8001aa4:	4290      	cmp	r0, r2
 8001aa6:	d00e      	beq.n	8001ac6 <TIM_TimeBaseInit+0x36>
 8001aa8:	f1b0 4f80 	cmp.w	r0, #1073741824	; 0x40000000
 8001aac:	d00b      	beq.n	8001ac6 <TIM_TimeBaseInit+0x36>
 8001aae:	f5a2 3298 	sub.w	r2, r2, #77824	; 0x13000
 8001ab2:	4290      	cmp	r0, r2
 8001ab4:	d007      	beq.n	8001ac6 <TIM_TimeBaseInit+0x36>
 8001ab6:	f502 6280 	add.w	r2, r2, #1024	; 0x400
 8001aba:	4290      	cmp	r0, r2
 8001abc:	d003      	beq.n	8001ac6 <TIM_TimeBaseInit+0x36>
 8001abe:	f502 32a4 	add.w	r2, r2, #83968	; 0x14800
 8001ac2:	4290      	cmp	r0, r2
 8001ac4:	d103      	bne.n	8001ace <TIM_TimeBaseInit+0x3e>
 8001ac6:	884a      	ldrh	r2, [r1, #2]
 8001ac8:	f023 0370 	bic.w	r3, r3, #112	; 0x70
 8001acc:	4313      	orrs	r3, r2
 8001ace:	4a17      	ldr	r2, [pc, #92]	; (8001b2c <TIM_TimeBaseInit+0x9c>)
 8001ad0:	4290      	cmp	r0, r2
 8001ad2:	d008      	beq.n	8001ae6 <TIM_TimeBaseInit+0x56>
 8001ad4:	f502 6280 	add.w	r2, r2, #1024	; 0x400
 8001ad8:	4290      	cmp	r0, r2
 8001ada:	bf1f      	itttt	ne
 8001adc:	f423 7340 	bicne.w	r3, r3, #768	; 0x300
 8001ae0:	890a      	ldrhne	r2, [r1, #8]
 8001ae2:	b29b      	uxthne	r3, r3
 8001ae4:	4313      	orrne	r3, r2
 8001ae6:	8003      	strh	r3, [r0, #0]
 8001ae8:	684b      	ldr	r3, [r1, #4]
 8001aea:	62c3      	str	r3, [r0, #44]	; 0x2c
 8001aec:	880b      	ldrh	r3, [r1, #0]
 8001aee:	8503      	strh	r3, [r0, #40]	; 0x28
 8001af0:	4b0d      	ldr	r3, [pc, #52]	; (8001b28 <TIM_TimeBaseInit+0x98>)
 8001af2:	4298      	cmp	r0, r3
 8001af4:	d013      	beq.n	8001b1e <TIM_TimeBaseInit+0x8e>
 8001af6:	f503 6300 	add.w	r3, r3, #2048	; 0x800
 8001afa:	4298      	cmp	r0, r3
 8001afc:	d00f      	beq.n	8001b1e <TIM_TimeBaseInit+0x8e>
 8001afe:	f503 6340 	add.w	r3, r3, #3072	; 0xc00
 8001b02:	4298      	cmp	r0, r3
 8001b04:	d00b      	beq.n	8001b1e <TIM_TimeBaseInit+0x8e>
 8001b06:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8001b0a:	4298      	cmp	r0, r3
 8001b0c:	d007      	beq.n	8001b1e <TIM_TimeBaseInit+0x8e>
 8001b0e:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8001b12:	4298      	cmp	r0, r3
 8001b14:	d003      	beq.n	8001b1e <TIM_TimeBaseInit+0x8e>
 8001b16:	f503 6300 	add.w	r3, r3, #2048	; 0x800
 8001b1a:	4298      	cmp	r0, r3
 8001b1c:	d101      	bne.n	8001b22 <TIM_TimeBaseInit+0x92>
 8001b1e:	894b      	ldrh	r3, [r1, #10]
 8001b20:	8603      	strh	r3, [r0, #48]	; 0x30
 8001b22:	2301      	movs	r3, #1
 8001b24:	6143      	str	r3, [r0, #20]
 8001b26:	4770      	bx	lr
 8001b28:	40012c00 	.word	0x40012c00
 8001b2c:	40001000 	.word	0x40001000

08001b30 <TIM_Cmd>:
 8001b30:	bf00      	nop
 8001b32:	bf00      	nop
 8001b34:	8803      	ldrh	r3, [r0, #0]
 8001b36:	b119      	cbz	r1, 8001b40 <TIM_Cmd+0x10>
 8001b38:	b29b      	uxth	r3, r3
 8001b3a:	f043 0301 	orr.w	r3, r3, #1
 8001b3e:	e003      	b.n	8001b48 <TIM_Cmd+0x18>
 8001b40:	f023 0301 	bic.w	r3, r3, #1
 8001b44:	041b      	lsls	r3, r3, #16
 8001b46:	0c1b      	lsrs	r3, r3, #16
 8001b48:	8003      	strh	r3, [r0, #0]
 8001b4a:	4770      	bx	lr

08001b4c <TIM_ClearITPendingBit>:
 8001b4c:	bf00      	nop
 8001b4e:	43c9      	mvns	r1, r1
 8001b50:	b289      	uxth	r1, r1
 8001b52:	6101      	str	r1, [r0, #16]
 8001b54:	4770      	bx	lr
	...

08001b58 <timer_init>:
 8001b58:	b530      	push	{r4, r5, lr}
 8001b5a:	2300      	movs	r3, #0
 8001b5c:	b085      	sub	sp, #20
 8001b5e:	491f      	ldr	r1, [pc, #124]	; (8001bdc <timer_init+0x84>)
 8001b60:	f44f 6280 	mov.w	r2, #1024	; 0x400
 8001b64:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001b68:	491d      	ldr	r1, [pc, #116]	; (8001be0 <timer_init+0x88>)
 8001b6a:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001b6e:	4a1d      	ldr	r2, [pc, #116]	; (8001be4 <timer_init+0x8c>)
 8001b70:	2400      	movs	r4, #0
 8001b72:	f822 4013 	strh.w	r4, [r2, r3, lsl #1]
 8001b76:	3301      	adds	r3, #1
 8001b78:	2b04      	cmp	r3, #4
 8001b7a:	4625      	mov	r5, r4
 8001b7c:	d1ef      	bne.n	8001b5e <timer_init+0x6>
 8001b7e:	4b1a      	ldr	r3, [pc, #104]	; (8001be8 <timer_init+0x90>)
 8001b80:	2002      	movs	r0, #2
 8001b82:	2101      	movs	r1, #1
 8001b84:	601c      	str	r4, [r3, #0]
 8001b86:	f000 fa49 	bl	800201c <RCC_APB1PeriphClockCmd>
 8001b8a:	f8ad 4006 	strh.w	r4, [sp, #6]
 8001b8e:	f8ad 400c 	strh.w	r4, [sp, #12]
 8001b92:	f8ad 400e 	strh.w	r4, [sp, #14]
 8001b96:	4c15      	ldr	r4, [pc, #84]	; (8001bec <timer_init+0x94>)
 8001b98:	f44f 738c 	mov.w	r3, #280	; 0x118
 8001b9c:	f8ad 3004 	strh.w	r3, [sp, #4]
 8001ba0:	4620      	mov	r0, r4
 8001ba2:	2331      	movs	r3, #49	; 0x31
 8001ba4:	a901      	add	r1, sp, #4
 8001ba6:	9302      	str	r3, [sp, #8]
 8001ba8:	f7ff ff72 	bl	8001a90 <TIM_TimeBaseInit>
 8001bac:	4620      	mov	r0, r4
 8001bae:	2101      	movs	r1, #1
 8001bb0:	f7ff ffbe 	bl	8001b30 <TIM_Cmd>
 8001bb4:	68e3      	ldr	r3, [r4, #12]
 8001bb6:	f043 0301 	orr.w	r3, r3, #1
 8001bba:	60e3      	str	r3, [r4, #12]
 8001bbc:	231d      	movs	r3, #29
 8001bbe:	f88d 3000 	strb.w	r3, [sp]
 8001bc2:	4668      	mov	r0, sp
 8001bc4:	2301      	movs	r3, #1
 8001bc6:	f88d 5001 	strb.w	r5, [sp, #1]
 8001bca:	f88d 3002 	strb.w	r3, [sp, #2]
 8001bce:	f88d 3003 	strb.w	r3, [sp, #3]
 8001bd2:	f7ff ff23 	bl	8001a1c <NVIC_Init>
 8001bd6:	b005      	add	sp, #20
 8001bd8:	bd30      	pop	{r4, r5, pc}
 8001bda:	bf00      	nop
 8001bdc:	20000ca4 	.word	0x20000ca4
 8001be0:	20000c98 	.word	0x20000c98
 8001be4:	20000c90 	.word	0x20000c90
 8001be8:	20000ca0 	.word	0x20000ca0
 8001bec:	40000400 	.word	0x40000400

08001bf0 <TIM3_IRQHandler>:
 8001bf0:	2300      	movs	r3, #0
 8001bf2:	4910      	ldr	r1, [pc, #64]	; (8001c34 <TIM3_IRQHandler+0x44>)
 8001bf4:	f831 2013 	ldrh.w	r2, [r1, r3, lsl #1]
 8001bf8:	b292      	uxth	r2, r2
 8001bfa:	b132      	cbz	r2, 8001c0a <TIM3_IRQHandler+0x1a>
 8001bfc:	f831 2013 	ldrh.w	r2, [r1, r3, lsl #1]
 8001c00:	3a01      	subs	r2, #1
 8001c02:	b292      	uxth	r2, r2
 8001c04:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001c08:	e009      	b.n	8001c1e <TIM3_IRQHandler+0x2e>
 8001c0a:	4a0b      	ldr	r2, [pc, #44]	; (8001c38 <TIM3_IRQHandler+0x48>)
 8001c0c:	f832 2013 	ldrh.w	r2, [r2, r3, lsl #1]
 8001c10:	b292      	uxth	r2, r2
 8001c12:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001c16:	4a09      	ldr	r2, [pc, #36]	; (8001c3c <TIM3_IRQHandler+0x4c>)
 8001c18:	2101      	movs	r1, #1
 8001c1a:	f822 1013 	strh.w	r1, [r2, r3, lsl #1]
 8001c1e:	3301      	adds	r3, #1
 8001c20:	2b04      	cmp	r3, #4
 8001c22:	d1e6      	bne.n	8001bf2 <TIM3_IRQHandler+0x2>
 8001c24:	4a06      	ldr	r2, [pc, #24]	; (8001c40 <TIM3_IRQHandler+0x50>)
 8001c26:	4807      	ldr	r0, [pc, #28]	; (8001c44 <TIM3_IRQHandler+0x54>)
 8001c28:	6813      	ldr	r3, [r2, #0]
 8001c2a:	2101      	movs	r1, #1
 8001c2c:	3301      	adds	r3, #1
 8001c2e:	6013      	str	r3, [r2, #0]
 8001c30:	f7ff bf8c 	b.w	8001b4c <TIM_ClearITPendingBit>
 8001c34:	20000ca4 	.word	0x20000ca4
 8001c38:	20000c98 	.word	0x20000c98
 8001c3c:	20000c90 	.word	0x20000c90
 8001c40:	20000ca0 	.word	0x20000ca0
 8001c44:	40000400 	.word	0x40000400

08001c48 <timer_get_time>:
 8001c48:	b082      	sub	sp, #8
 8001c4a:	b672      	cpsid	i
 8001c4c:	4b04      	ldr	r3, [pc, #16]	; (8001c60 <timer_get_time+0x18>)
 8001c4e:	681b      	ldr	r3, [r3, #0]
 8001c50:	9301      	str	r3, [sp, #4]
 8001c52:	b662      	cpsie	i
 8001c54:	230a      	movs	r3, #10
 8001c56:	9801      	ldr	r0, [sp, #4]
 8001c58:	fbb0 f0f3 	udiv	r0, r0, r3
 8001c5c:	b002      	add	sp, #8
 8001c5e:	4770      	bx	lr
 8001c60:	20000ca0 	.word	0x20000ca0

08001c64 <timer_delay_ms>:
 8001c64:	b513      	push	{r0, r1, r4, lr}
 8001c66:	4604      	mov	r4, r0
 8001c68:	f7ff ffee 	bl	8001c48 <timer_get_time>
 8001c6c:	4420      	add	r0, r4
 8001c6e:	9001      	str	r0, [sp, #4]
 8001c70:	9c01      	ldr	r4, [sp, #4]
 8001c72:	f7ff ffe9 	bl	8001c48 <timer_get_time>
 8001c76:	4284      	cmp	r4, r0
 8001c78:	d902      	bls.n	8001c80 <timer_delay_ms+0x1c>
 8001c7a:	f000 fca3 	bl	80025c4 <sleep>
 8001c7e:	e7f7      	b.n	8001c70 <timer_delay_ms+0xc>
 8001c80:	b002      	add	sp, #8
 8001c82:	bd10      	pop	{r4, pc}

08001c84 <event_timer_set_period>:
 8001c84:	b672      	cpsid	i
 8001c86:	eb01 0181 	add.w	r1, r1, r1, lsl #2
 8001c8a:	4b07      	ldr	r3, [pc, #28]	; (8001ca8 <event_timer_set_period+0x24>)
 8001c8c:	0049      	lsls	r1, r1, #1
 8001c8e:	b289      	uxth	r1, r1
 8001c90:	f823 1010 	strh.w	r1, [r3, r0, lsl #1]
 8001c94:	4b05      	ldr	r3, [pc, #20]	; (8001cac <event_timer_set_period+0x28>)
 8001c96:	f823 1010 	strh.w	r1, [r3, r0, lsl #1]
 8001c9a:	4b05      	ldr	r3, [pc, #20]	; (8001cb0 <event_timer_set_period+0x2c>)
 8001c9c:	2200      	movs	r2, #0
 8001c9e:	f823 2010 	strh.w	r2, [r3, r0, lsl #1]
 8001ca2:	b662      	cpsie	i
 8001ca4:	4770      	bx	lr
 8001ca6:	bf00      	nop
 8001ca8:	20000ca4 	.word	0x20000ca4
 8001cac:	20000c98 	.word	0x20000c98
 8001cb0:	20000c90 	.word	0x20000c90

08001cb4 <event_timer_wait>:
 8001cb4:	b510      	push	{r4, lr}
 8001cb6:	4604      	mov	r4, r0
 8001cb8:	4a06      	ldr	r2, [pc, #24]	; (8001cd4 <event_timer_wait+0x20>)
 8001cba:	f832 3014 	ldrh.w	r3, [r2, r4, lsl #1]
 8001cbe:	b29b      	uxth	r3, r3
 8001cc0:	b913      	cbnz	r3, 8001cc8 <event_timer_wait+0x14>
 8001cc2:	f000 fc7f 	bl	80025c4 <sleep>
 8001cc6:	e7f7      	b.n	8001cb8 <event_timer_wait+0x4>
 8001cc8:	b672      	cpsid	i
 8001cca:	2300      	movs	r3, #0
 8001ccc:	f822 3014 	strh.w	r3, [r2, r4, lsl #1]
 8001cd0:	b662      	cpsie	i
 8001cd2:	bd10      	pop	{r4, pc}
 8001cd4:	20000c90 	.word	0x20000c90

08001cd8 <RCC_GetClocksFreq>:
 8001cd8:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
 8001cdc:	4f9b      	ldr	r7, [pc, #620]	; (8001f4c <RCC_GetClocksFreq+0x274>)
 8001cde:	687b      	ldr	r3, [r7, #4]
 8001ce0:	f003 030c 	and.w	r3, r3, #12
 8001ce4:	2b04      	cmp	r3, #4
 8001ce6:	d005      	beq.n	8001cf4 <RCC_GetClocksFreq+0x1c>
 8001ce8:	2b08      	cmp	r3, #8
 8001cea:	d006      	beq.n	8001cfa <RCC_GetClocksFreq+0x22>
 8001cec:	4a98      	ldr	r2, [pc, #608]	; (8001f50 <RCC_GetClocksFreq+0x278>)
 8001cee:	6002      	str	r2, [r0, #0]
 8001cf0:	b9b3      	cbnz	r3, 8001d20 <RCC_GetClocksFreq+0x48>
 8001cf2:	e016      	b.n	8001d22 <RCC_GetClocksFreq+0x4a>
 8001cf4:	4b96      	ldr	r3, [pc, #600]	; (8001f50 <RCC_GetClocksFreq+0x278>)
 8001cf6:	6003      	str	r3, [r0, #0]
 8001cf8:	e012      	b.n	8001d20 <RCC_GetClocksFreq+0x48>
 8001cfa:	687b      	ldr	r3, [r7, #4]
 8001cfc:	6879      	ldr	r1, [r7, #4]
 8001cfe:	f3c3 4383 	ubfx	r3, r3, #18, #4
 8001d02:	1c9a      	adds	r2, r3, #2
 8001d04:	03cb      	lsls	r3, r1, #15
 8001d06:	bf49      	itett	mi
 8001d08:	6afb      	ldrmi	r3, [r7, #44]	; 0x2c
 8001d0a:	4b92      	ldrpl	r3, [pc, #584]	; (8001f54 <RCC_GetClocksFreq+0x27c>)
 8001d0c:	4990      	ldrmi	r1, [pc, #576]	; (8001f50 <RCC_GetClocksFreq+0x278>)
 8001d0e:	f003 030f 	andmi.w	r3, r3, #15
 8001d12:	bf44      	itt	mi
 8001d14:	3301      	addmi	r3, #1
 8001d16:	fbb1 f3f3 	udivmi	r3, r1, r3
 8001d1a:	4353      	muls	r3, r2
 8001d1c:	6003      	str	r3, [r0, #0]
 8001d1e:	e000      	b.n	8001d22 <RCC_GetClocksFreq+0x4a>
 8001d20:	2300      	movs	r3, #0
 8001d22:	687a      	ldr	r2, [r7, #4]
 8001d24:	4e8c      	ldr	r6, [pc, #560]	; (8001f58 <RCC_GetClocksFreq+0x280>)
 8001d26:	f8df c234 	ldr.w	ip, [pc, #564]	; 8001f5c <RCC_GetClocksFreq+0x284>
 8001d2a:	f3c2 1203 	ubfx	r2, r2, #4, #4
 8001d2e:	5cb4      	ldrb	r4, [r6, r2]
 8001d30:	6802      	ldr	r2, [r0, #0]
 8001d32:	b2e4      	uxtb	r4, r4
 8001d34:	fa22 f104 	lsr.w	r1, r2, r4
 8001d38:	6041      	str	r1, [r0, #4]
 8001d3a:	687d      	ldr	r5, [r7, #4]
 8001d3c:	f3c5 2502 	ubfx	r5, r5, #8, #3
 8001d40:	5d75      	ldrb	r5, [r6, r5]
 8001d42:	fa21 fe05 	lsr.w	lr, r1, r5
 8001d46:	f8c0 e008 	str.w	lr, [r0, #8]
 8001d4a:	687d      	ldr	r5, [r7, #4]
 8001d4c:	f3c5 25c2 	ubfx	r5, r5, #11, #3
 8001d50:	5d75      	ldrb	r5, [r6, r5]
 8001d52:	b2ed      	uxtb	r5, r5
 8001d54:	40e9      	lsrs	r1, r5
 8001d56:	60c1      	str	r1, [r0, #12]
 8001d58:	6afe      	ldr	r6, [r7, #44]	; 0x2c
 8001d5a:	f3c6 1804 	ubfx	r8, r6, #4, #5
 8001d5e:	f008 060f 	and.w	r6, r8, #15
 8001d62:	f018 0f10 	tst.w	r8, #16
 8001d66:	f83c 6016 	ldrh.w	r6, [ip, r6, lsl #1]
 8001d6a:	46e0      	mov	r8, ip
 8001d6c:	b2b6      	uxth	r6, r6
 8001d6e:	d004      	beq.n	8001d7a <RCC_GetClocksFreq+0xa2>
 8001d70:	b11e      	cbz	r6, 8001d7a <RCC_GetClocksFreq+0xa2>
 8001d72:	fbb3 f6f6 	udiv	r6, r3, r6
 8001d76:	6106      	str	r6, [r0, #16]
 8001d78:	e000      	b.n	8001d7c <RCC_GetClocksFreq+0xa4>
 8001d7a:	6102      	str	r2, [r0, #16]
 8001d7c:	6afe      	ldr	r6, [r7, #44]	; 0x2c
 8001d7e:	f3c6 2c44 	ubfx	ip, r6, #9, #5
 8001d82:	f00c 060f 	and.w	r6, ip, #15
 8001d86:	f01c 0f10 	tst.w	ip, #16
 8001d8a:	f838 6016 	ldrh.w	r6, [r8, r6, lsl #1]
 8001d8e:	b2b6      	uxth	r6, r6
 8001d90:	d004      	beq.n	8001d9c <RCC_GetClocksFreq+0xc4>
 8001d92:	b11e      	cbz	r6, 8001d9c <RCC_GetClocksFreq+0xc4>
 8001d94:	fbb3 f6f6 	udiv	r6, r3, r6
 8001d98:	6146      	str	r6, [r0, #20]
 8001d9a:	e000      	b.n	8001d9e <RCC_GetClocksFreq+0xc6>
 8001d9c:	6142      	str	r2, [r0, #20]
 8001d9e:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001da0:	06f6      	lsls	r6, r6, #27
 8001da2:	bf5a      	itte	pl
 8001da4:	4e6a      	ldrpl	r6, [pc, #424]	; (8001f50 <RCC_GetClocksFreq+0x278>)
 8001da6:	6186      	strpl	r6, [r0, #24]
 8001da8:	6182      	strmi	r2, [r0, #24]
 8001daa:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001dac:	06b6      	lsls	r6, r6, #26
 8001dae:	bf5a      	itte	pl
 8001db0:	4e67      	ldrpl	r6, [pc, #412]	; (8001f50 <RCC_GetClocksFreq+0x278>)
 8001db2:	61c6      	strpl	r6, [r0, #28]
 8001db4:	61c2      	strmi	r2, [r0, #28]
 8001db6:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001db8:	0676      	lsls	r6, r6, #25
 8001dba:	bf5a      	itte	pl
 8001dbc:	4e64      	ldrpl	r6, [pc, #400]	; (8001f50 <RCC_GetClocksFreq+0x278>)
 8001dbe:	6206      	strpl	r6, [r0, #32]
 8001dc0:	6202      	strmi	r2, [r0, #32]
 8001dc2:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001dc4:	05f6      	lsls	r6, r6, #23
 8001dc6:	d506      	bpl.n	8001dd6 <RCC_GetClocksFreq+0xfe>
 8001dc8:	429a      	cmp	r2, r3
 8001dca:	d104      	bne.n	8001dd6 <RCC_GetClocksFreq+0xfe>
 8001dcc:	42a5      	cmp	r5, r4
 8001dce:	d102      	bne.n	8001dd6 <RCC_GetClocksFreq+0xfe>
 8001dd0:	0056      	lsls	r6, r2, #1
 8001dd2:	6246      	str	r6, [r0, #36]	; 0x24
 8001dd4:	e000      	b.n	8001dd8 <RCC_GetClocksFreq+0x100>
 8001dd6:	6241      	str	r1, [r0, #36]	; 0x24
 8001dd8:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001dda:	04f6      	lsls	r6, r6, #19
 8001ddc:	d506      	bpl.n	8001dec <RCC_GetClocksFreq+0x114>
 8001dde:	429a      	cmp	r2, r3
 8001de0:	d104      	bne.n	8001dec <RCC_GetClocksFreq+0x114>
 8001de2:	42a5      	cmp	r5, r4
 8001de4:	d102      	bne.n	8001dec <RCC_GetClocksFreq+0x114>
 8001de6:	0056      	lsls	r6, r2, #1
 8001de8:	6286      	str	r6, [r0, #40]	; 0x28
 8001dea:	e000      	b.n	8001dee <RCC_GetClocksFreq+0x116>
 8001dec:	6281      	str	r1, [r0, #40]	; 0x28
 8001dee:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001df0:	05b6      	lsls	r6, r6, #22
 8001df2:	d506      	bpl.n	8001e02 <RCC_GetClocksFreq+0x12a>
 8001df4:	429a      	cmp	r2, r3
 8001df6:	d104      	bne.n	8001e02 <RCC_GetClocksFreq+0x12a>
 8001df8:	42a5      	cmp	r5, r4
 8001dfa:	d102      	bne.n	8001e02 <RCC_GetClocksFreq+0x12a>
 8001dfc:	0056      	lsls	r6, r2, #1
 8001dfe:	62c6      	str	r6, [r0, #44]	; 0x2c
 8001e00:	e000      	b.n	8001e04 <RCC_GetClocksFreq+0x12c>
 8001e02:	62c1      	str	r1, [r0, #44]	; 0x2c
 8001e04:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001e06:	0576      	lsls	r6, r6, #21
 8001e08:	d506      	bpl.n	8001e18 <RCC_GetClocksFreq+0x140>
 8001e0a:	429a      	cmp	r2, r3
 8001e0c:	d104      	bne.n	8001e18 <RCC_GetClocksFreq+0x140>
 8001e0e:	42a5      	cmp	r5, r4
 8001e10:	d102      	bne.n	8001e18 <RCC_GetClocksFreq+0x140>
 8001e12:	0056      	lsls	r6, r2, #1
 8001e14:	64c6      	str	r6, [r0, #76]	; 0x4c
 8001e16:	e000      	b.n	8001e1a <RCC_GetClocksFreq+0x142>
 8001e18:	64c1      	str	r1, [r0, #76]	; 0x4c
 8001e1a:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001e1c:	0536      	lsls	r6, r6, #20
 8001e1e:	d506      	bpl.n	8001e2e <RCC_GetClocksFreq+0x156>
 8001e20:	429a      	cmp	r2, r3
 8001e22:	d104      	bne.n	8001e2e <RCC_GetClocksFreq+0x156>
 8001e24:	42a5      	cmp	r5, r4
 8001e26:	d102      	bne.n	8001e2e <RCC_GetClocksFreq+0x156>
 8001e28:	0056      	lsls	r6, r2, #1
 8001e2a:	6506      	str	r6, [r0, #80]	; 0x50
 8001e2c:	e000      	b.n	8001e30 <RCC_GetClocksFreq+0x158>
 8001e2e:	6501      	str	r1, [r0, #80]	; 0x50
 8001e30:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001e32:	04b6      	lsls	r6, r6, #18
 8001e34:	d506      	bpl.n	8001e44 <RCC_GetClocksFreq+0x16c>
 8001e36:	429a      	cmp	r2, r3
 8001e38:	d104      	bne.n	8001e44 <RCC_GetClocksFreq+0x16c>
 8001e3a:	42a5      	cmp	r5, r4
 8001e3c:	d102      	bne.n	8001e44 <RCC_GetClocksFreq+0x16c>
 8001e3e:	0056      	lsls	r6, r2, #1
 8001e40:	6546      	str	r6, [r0, #84]	; 0x54
 8001e42:	e000      	b.n	8001e46 <RCC_GetClocksFreq+0x16e>
 8001e44:	6501      	str	r1, [r0, #80]	; 0x50
 8001e46:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001e48:	0436      	lsls	r6, r6, #16
 8001e4a:	d506      	bpl.n	8001e5a <RCC_GetClocksFreq+0x182>
 8001e4c:	429a      	cmp	r2, r3
 8001e4e:	d104      	bne.n	8001e5a <RCC_GetClocksFreq+0x182>
 8001e50:	42a5      	cmp	r5, r4
 8001e52:	d102      	bne.n	8001e5a <RCC_GetClocksFreq+0x182>
 8001e54:	0053      	lsls	r3, r2, #1
 8001e56:	6583      	str	r3, [r0, #88]	; 0x58
 8001e58:	e000      	b.n	8001e5c <RCC_GetClocksFreq+0x184>
 8001e5a:	6581      	str	r1, [r0, #88]	; 0x58
 8001e5c:	6b3c      	ldr	r4, [r7, #48]	; 0x30
 8001e5e:	4b3b      	ldr	r3, [pc, #236]	; (8001f4c <RCC_GetClocksFreq+0x274>)
 8001e60:	07a4      	lsls	r4, r4, #30
 8001e62:	d101      	bne.n	8001e68 <RCC_GetClocksFreq+0x190>
 8001e64:	6381      	str	r1, [r0, #56]	; 0x38
 8001e66:	e015      	b.n	8001e94 <RCC_GetClocksFreq+0x1bc>
 8001e68:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001e6a:	f001 0103 	and.w	r1, r1, #3
 8001e6e:	2901      	cmp	r1, #1
 8001e70:	d101      	bne.n	8001e76 <RCC_GetClocksFreq+0x19e>
 8001e72:	6382      	str	r2, [r0, #56]	; 0x38
 8001e74:	e00e      	b.n	8001e94 <RCC_GetClocksFreq+0x1bc>
 8001e76:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001e78:	f001 0103 	and.w	r1, r1, #3
 8001e7c:	2902      	cmp	r1, #2
 8001e7e:	d102      	bne.n	8001e86 <RCC_GetClocksFreq+0x1ae>
 8001e80:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8001e84:	e005      	b.n	8001e92 <RCC_GetClocksFreq+0x1ba>
 8001e86:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001e88:	f003 0303 	and.w	r3, r3, #3
 8001e8c:	2b03      	cmp	r3, #3
 8001e8e:	d101      	bne.n	8001e94 <RCC_GetClocksFreq+0x1bc>
 8001e90:	4b2f      	ldr	r3, [pc, #188]	; (8001f50 <RCC_GetClocksFreq+0x278>)
 8001e92:	6383      	str	r3, [r0, #56]	; 0x38
 8001e94:	6b39      	ldr	r1, [r7, #48]	; 0x30
 8001e96:	4b2d      	ldr	r3, [pc, #180]	; (8001f4c <RCC_GetClocksFreq+0x274>)
 8001e98:	f411 3f40 	tst.w	r1, #196608	; 0x30000
 8001e9c:	d102      	bne.n	8001ea4 <RCC_GetClocksFreq+0x1cc>
 8001e9e:	f8c0 e03c 	str.w	lr, [r0, #60]	; 0x3c
 8001ea2:	e018      	b.n	8001ed6 <RCC_GetClocksFreq+0x1fe>
 8001ea4:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001ea6:	f401 3140 	and.w	r1, r1, #196608	; 0x30000
 8001eaa:	f5b1 3f80 	cmp.w	r1, #65536	; 0x10000
 8001eae:	d101      	bne.n	8001eb4 <RCC_GetClocksFreq+0x1dc>
 8001eb0:	63c2      	str	r2, [r0, #60]	; 0x3c
 8001eb2:	e010      	b.n	8001ed6 <RCC_GetClocksFreq+0x1fe>
 8001eb4:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001eb6:	f401 3140 	and.w	r1, r1, #196608	; 0x30000
 8001eba:	f5b1 3f00 	cmp.w	r1, #131072	; 0x20000
 8001ebe:	d102      	bne.n	8001ec6 <RCC_GetClocksFreq+0x1ee>
 8001ec0:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8001ec4:	e006      	b.n	8001ed4 <RCC_GetClocksFreq+0x1fc>
 8001ec6:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001ec8:	f403 3340 	and.w	r3, r3, #196608	; 0x30000
 8001ecc:	f5b3 3f40 	cmp.w	r3, #196608	; 0x30000
 8001ed0:	d101      	bne.n	8001ed6 <RCC_GetClocksFreq+0x1fe>
 8001ed2:	4b1f      	ldr	r3, [pc, #124]	; (8001f50 <RCC_GetClocksFreq+0x278>)
 8001ed4:	63c3      	str	r3, [r0, #60]	; 0x3c
 8001ed6:	6b39      	ldr	r1, [r7, #48]	; 0x30
 8001ed8:	4b1c      	ldr	r3, [pc, #112]	; (8001f4c <RCC_GetClocksFreq+0x274>)
 8001eda:	f411 2f40 	tst.w	r1, #786432	; 0xc0000
 8001ede:	d102      	bne.n	8001ee6 <RCC_GetClocksFreq+0x20e>
 8001ee0:	f8c0 e040 	str.w	lr, [r0, #64]	; 0x40
 8001ee4:	e018      	b.n	8001f18 <RCC_GetClocksFreq+0x240>
 8001ee6:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001ee8:	f401 2140 	and.w	r1, r1, #786432	; 0xc0000
 8001eec:	f5b1 2f80 	cmp.w	r1, #262144	; 0x40000
 8001ef0:	d101      	bne.n	8001ef6 <RCC_GetClocksFreq+0x21e>
 8001ef2:	6402      	str	r2, [r0, #64]	; 0x40
 8001ef4:	e010      	b.n	8001f18 <RCC_GetClocksFreq+0x240>
 8001ef6:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001ef8:	f401 2140 	and.w	r1, r1, #786432	; 0xc0000
 8001efc:	f5b1 2f00 	cmp.w	r1, #524288	; 0x80000
 8001f00:	d102      	bne.n	8001f08 <RCC_GetClocksFreq+0x230>
 8001f02:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8001f06:	e006      	b.n	8001f16 <RCC_GetClocksFreq+0x23e>
 8001f08:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001f0a:	f403 2340 	and.w	r3, r3, #786432	; 0xc0000
 8001f0e:	f5b3 2f40 	cmp.w	r3, #786432	; 0xc0000
 8001f12:	d101      	bne.n	8001f18 <RCC_GetClocksFreq+0x240>
 8001f14:	4b0e      	ldr	r3, [pc, #56]	; (8001f50 <RCC_GetClocksFreq+0x278>)
 8001f16:	6403      	str	r3, [r0, #64]	; 0x40
 8001f18:	6b39      	ldr	r1, [r7, #48]	; 0x30
 8001f1a:	4b0c      	ldr	r3, [pc, #48]	; (8001f4c <RCC_GetClocksFreq+0x274>)
 8001f1c:	f411 1f40 	tst.w	r1, #3145728	; 0x300000
 8001f20:	d102      	bne.n	8001f28 <RCC_GetClocksFreq+0x250>
 8001f22:	f8c0 e044 	str.w	lr, [r0, #68]	; 0x44
 8001f26:	e023      	b.n	8001f70 <RCC_GetClocksFreq+0x298>
 8001f28:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001f2a:	f401 1140 	and.w	r1, r1, #3145728	; 0x300000
 8001f2e:	f5b1 1f80 	cmp.w	r1, #1048576	; 0x100000
 8001f32:	d101      	bne.n	8001f38 <RCC_GetClocksFreq+0x260>
 8001f34:	6442      	str	r2, [r0, #68]	; 0x44
 8001f36:	e01b      	b.n	8001f70 <RCC_GetClocksFreq+0x298>
 8001f38:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001f3a:	f401 1140 	and.w	r1, r1, #3145728	; 0x300000
 8001f3e:	f5b1 1f00 	cmp.w	r1, #2097152	; 0x200000
 8001f42:	d10d      	bne.n	8001f60 <RCC_GetClocksFreq+0x288>
 8001f44:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8001f48:	e011      	b.n	8001f6e <RCC_GetClocksFreq+0x296>
 8001f4a:	bf00      	nop
 8001f4c:	40021000 	.word	0x40021000
 8001f50:	007a1200 	.word	0x007a1200
 8001f54:	003d0900 	.word	0x003d0900
 8001f58:	20000020 	.word	0x20000020
 8001f5c:	20000000 	.word	0x20000000
 8001f60:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001f62:	f403 1340 	and.w	r3, r3, #3145728	; 0x300000
 8001f66:	f5b3 1f40 	cmp.w	r3, #3145728	; 0x300000
 8001f6a:	d101      	bne.n	8001f70 <RCC_GetClocksFreq+0x298>
 8001f6c:	4b13      	ldr	r3, [pc, #76]	; (8001fbc <RCC_GetClocksFreq+0x2e4>)
 8001f6e:	6443      	str	r3, [r0, #68]	; 0x44
 8001f70:	6b39      	ldr	r1, [r7, #48]	; 0x30
 8001f72:	4b13      	ldr	r3, [pc, #76]	; (8001fc0 <RCC_GetClocksFreq+0x2e8>)
 8001f74:	f411 0f40 	tst.w	r1, #12582912	; 0xc00000
 8001f78:	d103      	bne.n	8001f82 <RCC_GetClocksFreq+0x2aa>
 8001f7a:	f8c0 e048 	str.w	lr, [r0, #72]	; 0x48
 8001f7e:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 8001f82:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001f84:	f401 0140 	and.w	r1, r1, #12582912	; 0xc00000
 8001f88:	f5b1 0f80 	cmp.w	r1, #4194304	; 0x400000
 8001f8c:	d102      	bne.n	8001f94 <RCC_GetClocksFreq+0x2bc>
 8001f8e:	6482      	str	r2, [r0, #72]	; 0x48
 8001f90:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 8001f94:	6b1a      	ldr	r2, [r3, #48]	; 0x30
 8001f96:	f402 0240 	and.w	r2, r2, #12582912	; 0xc00000
 8001f9a:	f5b2 0f00 	cmp.w	r2, #8388608	; 0x800000
 8001f9e:	d102      	bne.n	8001fa6 <RCC_GetClocksFreq+0x2ce>
 8001fa0:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8001fa4:	e006      	b.n	8001fb4 <RCC_GetClocksFreq+0x2dc>
 8001fa6:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001fa8:	f403 0340 	and.w	r3, r3, #12582912	; 0xc00000
 8001fac:	f5b3 0f40 	cmp.w	r3, #12582912	; 0xc00000
 8001fb0:	d101      	bne.n	8001fb6 <RCC_GetClocksFreq+0x2de>
 8001fb2:	4b02      	ldr	r3, [pc, #8]	; (8001fbc <RCC_GetClocksFreq+0x2e4>)
 8001fb4:	6483      	str	r3, [r0, #72]	; 0x48
 8001fb6:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 8001fba:	bf00      	nop
 8001fbc:	007a1200 	.word	0x007a1200
 8001fc0:	40021000 	.word	0x40021000

08001fc4 <RCC_ADCCLKConfig>:
 8001fc4:	bf00      	nop
 8001fc6:	0f03      	lsrs	r3, r0, #28
 8001fc8:	4b05      	ldr	r3, [pc, #20]	; (8001fe0 <RCC_ADCCLKConfig+0x1c>)
 8001fca:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8001fcc:	bf14      	ite	ne
 8001fce:	f422 5278 	bicne.w	r2, r2, #15872	; 0x3e00
 8001fd2:	f422 72f8 	biceq.w	r2, r2, #496	; 0x1f0
 8001fd6:	62da      	str	r2, [r3, #44]	; 0x2c
 8001fd8:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8001fda:	4310      	orrs	r0, r2
 8001fdc:	62d8      	str	r0, [r3, #44]	; 0x2c
 8001fde:	4770      	bx	lr
 8001fe0:	40021000 	.word	0x40021000

08001fe4 <RCC_AHBPeriphClockCmd>:
 8001fe4:	bf00      	nop
 8001fe6:	bf00      	nop
 8001fe8:	4b04      	ldr	r3, [pc, #16]	; (8001ffc <RCC_AHBPeriphClockCmd+0x18>)
 8001fea:	695a      	ldr	r2, [r3, #20]
 8001fec:	b109      	cbz	r1, 8001ff2 <RCC_AHBPeriphClockCmd+0xe>
 8001fee:	4310      	orrs	r0, r2
 8001ff0:	e001      	b.n	8001ff6 <RCC_AHBPeriphClockCmd+0x12>
 8001ff2:	ea22 0000 	bic.w	r0, r2, r0
 8001ff6:	6158      	str	r0, [r3, #20]
 8001ff8:	4770      	bx	lr
 8001ffa:	bf00      	nop
 8001ffc:	40021000 	.word	0x40021000

08002000 <RCC_APB2PeriphClockCmd>:
 8002000:	bf00      	nop
 8002002:	bf00      	nop
 8002004:	4b04      	ldr	r3, [pc, #16]	; (8002018 <RCC_APB2PeriphClockCmd+0x18>)
 8002006:	699a      	ldr	r2, [r3, #24]
 8002008:	b109      	cbz	r1, 800200e <RCC_APB2PeriphClockCmd+0xe>
 800200a:	4310      	orrs	r0, r2
 800200c:	e001      	b.n	8002012 <RCC_APB2PeriphClockCmd+0x12>
 800200e:	ea22 0000 	bic.w	r0, r2, r0
 8002012:	6198      	str	r0, [r3, #24]
 8002014:	4770      	bx	lr
 8002016:	bf00      	nop
 8002018:	40021000 	.word	0x40021000

0800201c <RCC_APB1PeriphClockCmd>:
 800201c:	bf00      	nop
 800201e:	bf00      	nop
 8002020:	4b04      	ldr	r3, [pc, #16]	; (8002034 <RCC_APB1PeriphClockCmd+0x18>)
 8002022:	69da      	ldr	r2, [r3, #28]
 8002024:	b109      	cbz	r1, 800202a <RCC_APB1PeriphClockCmd+0xe>
 8002026:	4310      	orrs	r0, r2
 8002028:	e001      	b.n	800202e <RCC_APB1PeriphClockCmd+0x12>
 800202a:	ea22 0000 	bic.w	r0, r2, r0
 800202e:	61d8      	str	r0, [r3, #28]
 8002030:	4770      	bx	lr
 8002032:	bf00      	nop
 8002034:	40021000 	.word	0x40021000

08002038 <adc_init>:
 8002038:	b530      	push	{r4, r5, lr}
 800203a:	b08b      	sub	sp, #44	; 0x2c
 800203c:	2400      	movs	r4, #0
 800203e:	2303      	movs	r3, #3
 8002040:	4669      	mov	r1, sp
 8002042:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8002046:	f88d 3004 	strb.w	r3, [sp, #4]
 800204a:	9400      	str	r4, [sp, #0]
 800204c:	f88d 4007 	strb.w	r4, [sp, #7]
 8002050:	f000 fbd4 	bl	80027fc <GPIO_Init>
 8002054:	f44f 7088 	mov.w	r0, #272	; 0x110
 8002058:	f7ff ffb4 	bl	8001fc4 <RCC_ADCCLKConfig>
 800205c:	f04f 5080 	mov.w	r0, #268435456	; 0x10000000
 8002060:	2101      	movs	r1, #1
 8002062:	f7ff ffbf 	bl	8001fe4 <RCC_AHBPeriphClockCmd>
 8002066:	2501      	movs	r5, #1
 8002068:	a902      	add	r1, sp, #8
 800206a:	f04f 40a0 	mov.w	r0, #1342177280	; 0x50000000
 800206e:	9408      	str	r4, [sp, #32]
 8002070:	9402      	str	r4, [sp, #8]
 8002072:	9406      	str	r4, [sp, #24]
 8002074:	9404      	str	r4, [sp, #16]
 8002076:	9405      	str	r4, [sp, #20]
 8002078:	f88d 5024 	strb.w	r5, [sp, #36]	; 0x24
 800207c:	9407      	str	r4, [sp, #28]
 800207e:	9403      	str	r4, [sp, #12]
 8002080:	f000 f834 	bl	80020ec <ADC_Init>
 8002084:	462a      	mov	r2, r5
 8002086:	4623      	mov	r3, r4
 8002088:	f04f 40a0 	mov.w	r0, #1342177280	; 0x50000000
 800208c:	2102      	movs	r1, #2
 800208e:	f000 f85e 	bl	800214e <ADC_RegularChannelConfig>
 8002092:	f04f 40a0 	mov.w	r0, #1342177280	; 0x50000000
 8002096:	4629      	mov	r1, r5
 8002098:	f000 f84e 	bl	8002138 <ADC_Cmd>
 800209c:	b00b      	add	sp, #44	; 0x2c
 800209e:	bd30      	pop	{r4, r5, pc}

080020a0 <adc_read>:
 80020a0:	3801      	subs	r0, #1
 80020a2:	2807      	cmp	r0, #7
 80020a4:	bf98      	it	ls
 80020a6:	4b0f      	ldrls	r3, [pc, #60]	; (80020e4 <adc_read+0x44>)
 80020a8:	b510      	push	{r4, lr}
 80020aa:	bf9b      	ittet	ls
 80020ac:	f853 4020 	ldrls.w	r4, [r3, r0, lsl #2]
 80020b0:	4b0d      	ldrls	r3, [pc, #52]	; (80020e8 <adc_read+0x48>)
 80020b2:	f04f 44a0 	movhi.w	r4, #1342177280	; 0x50000000
 80020b6:	5c19      	ldrbls	r1, [r3, r0]
 80020b8:	bf88      	it	hi
 80020ba:	2101      	movhi	r1, #1
 80020bc:	4620      	mov	r0, r4
 80020be:	2201      	movs	r2, #1
 80020c0:	2300      	movs	r3, #0
 80020c2:	f000 f844 	bl	800214e <ADC_RegularChannelConfig>
 80020c6:	4620      	mov	r0, r4
 80020c8:	f000 f89f 	bl	800220a <ADC_StartConversion>
 80020cc:	4620      	mov	r0, r4
 80020ce:	2104      	movs	r1, #4
 80020d0:	f000 f8a5 	bl	800221e <ADC_GetFlagStatus>
 80020d4:	b908      	cbnz	r0, 80020da <adc_read+0x3a>
 80020d6:	bf00      	nop
 80020d8:	e7f8      	b.n	80020cc <adc_read+0x2c>
 80020da:	4620      	mov	r0, r4
 80020dc:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 80020e0:	f000 b899 	b.w	8002216 <ADC_GetConversionValue>
 80020e4:	08002ca0 	.word	0x08002ca0
 80020e8:	08002cc0 	.word	0x08002cc0

080020ec <ADC_Init>:
 80020ec:	b510      	push	{r4, lr}
 80020ee:	bf00      	nop
 80020f0:	bf00      	nop
 80020f2:	bf00      	nop
 80020f4:	bf00      	nop
 80020f6:	bf00      	nop
 80020f8:	bf00      	nop
 80020fa:	bf00      	nop
 80020fc:	bf00      	nop
 80020fe:	bf00      	nop
 8002100:	4b0c      	ldr	r3, [pc, #48]	; (8002134 <ADC_Init+0x48>)
 8002102:	68c2      	ldr	r2, [r0, #12]
 8002104:	4013      	ands	r3, r2
 8002106:	e891 0014 	ldmia.w	r1, {r2, r4}
 800210a:	4314      	orrs	r4, r2
 800210c:	688a      	ldr	r2, [r1, #8]
 800210e:	4314      	orrs	r4, r2
 8002110:	68ca      	ldr	r2, [r1, #12]
 8002112:	4314      	orrs	r4, r2
 8002114:	690a      	ldr	r2, [r1, #16]
 8002116:	4314      	orrs	r4, r2
 8002118:	694a      	ldr	r2, [r1, #20]
 800211a:	4314      	orrs	r4, r2
 800211c:	698a      	ldr	r2, [r1, #24]
 800211e:	4322      	orrs	r2, r4
 8002120:	4313      	orrs	r3, r2
 8002122:	60c3      	str	r3, [r0, #12]
 8002124:	6b03      	ldr	r3, [r0, #48]	; 0x30
 8002126:	f023 020f 	bic.w	r2, r3, #15
 800212a:	7f0b      	ldrb	r3, [r1, #28]
 800212c:	3b01      	subs	r3, #1
 800212e:	4313      	orrs	r3, r2
 8002130:	6303      	str	r3, [r0, #48]	; 0x30
 8002132:	bd10      	pop	{r4, pc}
 8002134:	fdffc007 	.word	0xfdffc007

08002138 <ADC_Cmd>:
 8002138:	bf00      	nop
 800213a:	bf00      	nop
 800213c:	6883      	ldr	r3, [r0, #8]
 800213e:	b111      	cbz	r1, 8002146 <ADC_Cmd+0xe>
 8002140:	f043 0301 	orr.w	r3, r3, #1
 8002144:	e001      	b.n	800214a <ADC_Cmd+0x12>
 8002146:	f043 0302 	orr.w	r3, r3, #2
 800214a:	6083      	str	r3, [r0, #8]
 800214c:	4770      	bx	lr

0800214e <ADC_RegularChannelConfig>:
 800214e:	b530      	push	{r4, r5, lr}
 8002150:	bf00      	nop
 8002152:	bf00      	nop
 8002154:	bf00      	nop
 8002156:	2a04      	cmp	r2, #4
 8002158:	d80c      	bhi.n	8002174 <ADC_RegularChannelConfig+0x26>
 800215a:	eb02 0242 	add.w	r2, r2, r2, lsl #1
 800215e:	6b05      	ldr	r5, [r0, #48]	; 0x30
 8002160:	0052      	lsls	r2, r2, #1
 8002162:	241f      	movs	r4, #31
 8002164:	4094      	lsls	r4, r2
 8002166:	ea25 0404 	bic.w	r4, r5, r4
 800216a:	fa01 f202 	lsl.w	r2, r1, r2
 800216e:	4322      	orrs	r2, r4
 8002170:	6302      	str	r2, [r0, #48]	; 0x30
 8002172:	e029      	b.n	80021c8 <ADC_RegularChannelConfig+0x7a>
 8002174:	2a09      	cmp	r2, #9
 8002176:	d80c      	bhi.n	8002192 <ADC_RegularChannelConfig+0x44>
 8002178:	2406      	movs	r4, #6
 800217a:	3a05      	subs	r2, #5
 800217c:	4362      	muls	r2, r4
 800217e:	6b45      	ldr	r5, [r0, #52]	; 0x34
 8002180:	241f      	movs	r4, #31
 8002182:	4094      	lsls	r4, r2
 8002184:	ea25 0404 	bic.w	r4, r5, r4
 8002188:	fa01 f202 	lsl.w	r2, r1, r2
 800218c:	4322      	orrs	r2, r4
 800218e:	6342      	str	r2, [r0, #52]	; 0x34
 8002190:	e01a      	b.n	80021c8 <ADC_RegularChannelConfig+0x7a>
 8002192:	2a0e      	cmp	r2, #14
 8002194:	f04f 0406 	mov.w	r4, #6
 8002198:	d80b      	bhi.n	80021b2 <ADC_RegularChannelConfig+0x64>
 800219a:	3a0a      	subs	r2, #10
 800219c:	4362      	muls	r2, r4
 800219e:	6b85      	ldr	r5, [r0, #56]	; 0x38
 80021a0:	241f      	movs	r4, #31
 80021a2:	4094      	lsls	r4, r2
 80021a4:	ea25 0404 	bic.w	r4, r5, r4
 80021a8:	fa01 f202 	lsl.w	r2, r1, r2
 80021ac:	4322      	orrs	r2, r4
 80021ae:	6382      	str	r2, [r0, #56]	; 0x38
 80021b0:	e00a      	b.n	80021c8 <ADC_RegularChannelConfig+0x7a>
 80021b2:	3a0f      	subs	r2, #15
 80021b4:	4362      	muls	r2, r4
 80021b6:	6bc5      	ldr	r5, [r0, #60]	; 0x3c
 80021b8:	241f      	movs	r4, #31
 80021ba:	4094      	lsls	r4, r2
 80021bc:	ea25 0404 	bic.w	r4, r5, r4
 80021c0:	fa01 f202 	lsl.w	r2, r1, r2
 80021c4:	4322      	orrs	r2, r4
 80021c6:	63c2      	str	r2, [r0, #60]	; 0x3c
 80021c8:	2909      	cmp	r1, #9
 80021ca:	d90e      	bls.n	80021ea <ADC_RegularChannelConfig+0x9c>
 80021cc:	390a      	subs	r1, #10
 80021ce:	6982      	ldr	r2, [r0, #24]
 80021d0:	6984      	ldr	r4, [r0, #24]
 80021d2:	eb01 0141 	add.w	r1, r1, r1, lsl #1
 80021d6:	2207      	movs	r2, #7
 80021d8:	408a      	lsls	r2, r1
 80021da:	ea24 0202 	bic.w	r2, r4, r2
 80021de:	6182      	str	r2, [r0, #24]
 80021e0:	6982      	ldr	r2, [r0, #24]
 80021e2:	408b      	lsls	r3, r1
 80021e4:	4313      	orrs	r3, r2
 80021e6:	6183      	str	r3, [r0, #24]
 80021e8:	bd30      	pop	{r4, r5, pc}
 80021ea:	3901      	subs	r1, #1
 80021ec:	6942      	ldr	r2, [r0, #20]
 80021ee:	6944      	ldr	r4, [r0, #20]
 80021f0:	eb01 0141 	add.w	r1, r1, r1, lsl #1
 80021f4:	2238      	movs	r2, #56	; 0x38
 80021f6:	408a      	lsls	r2, r1
 80021f8:	ea24 0202 	bic.w	r2, r4, r2
 80021fc:	6142      	str	r2, [r0, #20]
 80021fe:	6942      	ldr	r2, [r0, #20]
 8002200:	3103      	adds	r1, #3
 8002202:	408b      	lsls	r3, r1
 8002204:	4313      	orrs	r3, r2
 8002206:	6143      	str	r3, [r0, #20]
 8002208:	bd30      	pop	{r4, r5, pc}

0800220a <ADC_StartConversion>:
 800220a:	bf00      	nop
 800220c:	6883      	ldr	r3, [r0, #8]
 800220e:	f043 0304 	orr.w	r3, r3, #4
 8002212:	6083      	str	r3, [r0, #8]
 8002214:	4770      	bx	lr

08002216 <ADC_GetConversionValue>:
 8002216:	bf00      	nop
 8002218:	6c00      	ldr	r0, [r0, #64]	; 0x40
 800221a:	b280      	uxth	r0, r0
 800221c:	4770      	bx	lr

0800221e <ADC_GetFlagStatus>:
 800221e:	bf00      	nop
 8002220:	bf00      	nop
 8002222:	6803      	ldr	r3, [r0, #0]
 8002224:	4219      	tst	r1, r3
 8002226:	bf14      	ite	ne
 8002228:	2001      	movne	r0, #1
 800222a:	2000      	moveq	r0, #0
 800222c:	4770      	bx	lr
	...

08002230 <USART_Init>:
 8002230:	b530      	push	{r4, r5, lr}
 8002232:	4604      	mov	r4, r0
 8002234:	b099      	sub	sp, #100	; 0x64
 8002236:	460d      	mov	r5, r1
 8002238:	bf00      	nop
 800223a:	bf00      	nop
 800223c:	bf00      	nop
 800223e:	bf00      	nop
 8002240:	bf00      	nop
 8002242:	bf00      	nop
 8002244:	bf00      	nop
 8002246:	6803      	ldr	r3, [r0, #0]
 8002248:	f023 0301 	bic.w	r3, r3, #1
 800224c:	6003      	str	r3, [r0, #0]
 800224e:	6843      	ldr	r3, [r0, #4]
 8002250:	f423 5240 	bic.w	r2, r3, #12288	; 0x3000
 8002254:	688b      	ldr	r3, [r1, #8]
 8002256:	68c9      	ldr	r1, [r1, #12]
 8002258:	4313      	orrs	r3, r2
 800225a:	6043      	str	r3, [r0, #4]
 800225c:	686a      	ldr	r2, [r5, #4]
 800225e:	6803      	ldr	r3, [r0, #0]
 8002260:	4311      	orrs	r1, r2
 8002262:	692a      	ldr	r2, [r5, #16]
 8002264:	f423 53b0 	bic.w	r3, r3, #5632	; 0x1600
 8002268:	430a      	orrs	r2, r1
 800226a:	f023 030c 	bic.w	r3, r3, #12
 800226e:	4313      	orrs	r3, r2
 8002270:	6003      	str	r3, [r0, #0]
 8002272:	6883      	ldr	r3, [r0, #8]
 8002274:	f423 7240 	bic.w	r2, r3, #768	; 0x300
 8002278:	696b      	ldr	r3, [r5, #20]
 800227a:	4313      	orrs	r3, r2
 800227c:	6083      	str	r3, [r0, #8]
 800227e:	a801      	add	r0, sp, #4
 8002280:	f7ff fd2a 	bl	8001cd8 <RCC_GetClocksFreq>
 8002284:	4b17      	ldr	r3, [pc, #92]	; (80022e4 <USART_Init+0xb4>)
 8002286:	429c      	cmp	r4, r3
 8002288:	d101      	bne.n	800228e <USART_Init+0x5e>
 800228a:	9b0f      	ldr	r3, [sp, #60]	; 0x3c
 800228c:	e00e      	b.n	80022ac <USART_Init+0x7c>
 800228e:	4b16      	ldr	r3, [pc, #88]	; (80022e8 <USART_Init+0xb8>)
 8002290:	429c      	cmp	r4, r3
 8002292:	d101      	bne.n	8002298 <USART_Init+0x68>
 8002294:	9b10      	ldr	r3, [sp, #64]	; 0x40
 8002296:	e009      	b.n	80022ac <USART_Init+0x7c>
 8002298:	4b14      	ldr	r3, [pc, #80]	; (80022ec <USART_Init+0xbc>)
 800229a:	429c      	cmp	r4, r3
 800229c:	d101      	bne.n	80022a2 <USART_Init+0x72>
 800229e:	9b11      	ldr	r3, [sp, #68]	; 0x44
 80022a0:	e004      	b.n	80022ac <USART_Init+0x7c>
 80022a2:	4b13      	ldr	r3, [pc, #76]	; (80022f0 <USART_Init+0xc0>)
 80022a4:	429c      	cmp	r4, r3
 80022a6:	bf0c      	ite	eq
 80022a8:	9b12      	ldreq	r3, [sp, #72]	; 0x48
 80022aa:	9b13      	ldrne	r3, [sp, #76]	; 0x4c
 80022ac:	6822      	ldr	r2, [r4, #0]
 80022ae:	6829      	ldr	r1, [r5, #0]
 80022b0:	f412 4f00 	tst.w	r2, #32768	; 0x8000
 80022b4:	bf18      	it	ne
 80022b6:	005b      	lslne	r3, r3, #1
 80022b8:	fbb3 f2f1 	udiv	r2, r3, r1
 80022bc:	fb01 3312 	mls	r3, r1, r2, r3
 80022c0:	ebb3 0f51 	cmp.w	r3, r1, lsr #1
 80022c4:	6823      	ldr	r3, [r4, #0]
 80022c6:	bf28      	it	cs
 80022c8:	3201      	addcs	r2, #1
 80022ca:	041b      	lsls	r3, r3, #16
 80022cc:	bf41      	itttt	mi
 80022ce:	f64f 73f0 	movwmi	r3, #65520	; 0xfff0
 80022d2:	f3c2 0142 	ubfxmi	r1, r2, #1, #3
 80022d6:	4013      	andmi	r3, r2
 80022d8:	ea41 0203 	orrmi.w	r2, r1, r3
 80022dc:	b292      	uxth	r2, r2
 80022de:	81a2      	strh	r2, [r4, #12]
 80022e0:	b019      	add	sp, #100	; 0x64
 80022e2:	bd30      	pop	{r4, r5, pc}
 80022e4:	40013800 	.word	0x40013800
 80022e8:	40004400 	.word	0x40004400
 80022ec:	40004800 	.word	0x40004800
 80022f0:	40004c00 	.word	0x40004c00

080022f4 <USART_Cmd>:
 80022f4:	bf00      	nop
 80022f6:	bf00      	nop
 80022f8:	6803      	ldr	r3, [r0, #0]
 80022fa:	b111      	cbz	r1, 8002302 <USART_Cmd+0xe>
 80022fc:	f043 0301 	orr.w	r3, r3, #1
 8002300:	e001      	b.n	8002306 <USART_Cmd+0x12>
 8002302:	f023 0301 	bic.w	r3, r3, #1
 8002306:	6003      	str	r3, [r0, #0]
 8002308:	4770      	bx	lr

0800230a <USART_ReceiveData>:
 800230a:	bf00      	nop
 800230c:	8c80      	ldrh	r0, [r0, #36]	; 0x24
 800230e:	f3c0 0008 	ubfx	r0, r0, #0, #9
 8002312:	4770      	bx	lr

08002314 <USART_ITConfig>:
 8002314:	b510      	push	{r4, lr}
 8002316:	bf00      	nop
 8002318:	bf00      	nop
 800231a:	bf00      	nop
 800231c:	f3c1 2407 	ubfx	r4, r1, #8, #8
 8002320:	2301      	movs	r3, #1
 8002322:	b2c9      	uxtb	r1, r1
 8002324:	2c02      	cmp	r4, #2
 8002326:	fa03 f301 	lsl.w	r3, r3, r1
 800232a:	d101      	bne.n	8002330 <USART_ITConfig+0x1c>
 800232c:	3004      	adds	r0, #4
 800232e:	e002      	b.n	8002336 <USART_ITConfig+0x22>
 8002330:	2c03      	cmp	r4, #3
 8002332:	bf08      	it	eq
 8002334:	3008      	addeq	r0, #8
 8002336:	b112      	cbz	r2, 800233e <USART_ITConfig+0x2a>
 8002338:	6802      	ldr	r2, [r0, #0]
 800233a:	4313      	orrs	r3, r2
 800233c:	e002      	b.n	8002344 <USART_ITConfig+0x30>
 800233e:	6802      	ldr	r2, [r0, #0]
 8002340:	ea22 0303 	bic.w	r3, r2, r3
 8002344:	6003      	str	r3, [r0, #0]
 8002346:	bd10      	pop	{r4, pc}

08002348 <USART_GetITStatus>:
 8002348:	b510      	push	{r4, lr}
 800234a:	bf00      	nop
 800234c:	bf00      	nop
 800234e:	f3c1 2207 	ubfx	r2, r1, #8, #8
 8002352:	b2cc      	uxtb	r4, r1
 8002354:	2301      	movs	r3, #1
 8002356:	2a01      	cmp	r2, #1
 8002358:	fa03 f304 	lsl.w	r3, r3, r4
 800235c:	d101      	bne.n	8002362 <USART_GetITStatus+0x1a>
 800235e:	6802      	ldr	r2, [r0, #0]
 8002360:	e003      	b.n	800236a <USART_GetITStatus+0x22>
 8002362:	2a02      	cmp	r2, #2
 8002364:	bf0c      	ite	eq
 8002366:	6842      	ldreq	r2, [r0, #4]
 8002368:	6882      	ldrne	r2, [r0, #8]
 800236a:	4013      	ands	r3, r2
 800236c:	69c2      	ldr	r2, [r0, #28]
 800236e:	b13b      	cbz	r3, 8002380 <USART_GetITStatus+0x38>
 8002370:	0c09      	lsrs	r1, r1, #16
 8002372:	2301      	movs	r3, #1
 8002374:	408b      	lsls	r3, r1
 8002376:	4213      	tst	r3, r2
 8002378:	bf14      	ite	ne
 800237a:	2001      	movne	r0, #1
 800237c:	2000      	moveq	r0, #0
 800237e:	bd10      	pop	{r4, pc}
 8002380:	4618      	mov	r0, r3
 8002382:	bd10      	pop	{r4, pc}

08002384 <USART_ClearITPendingBit>:
 8002384:	bf00      	nop
 8002386:	bf00      	nop
 8002388:	2301      	movs	r3, #1
 800238a:	0c09      	lsrs	r1, r1, #16
 800238c:	408b      	lsls	r3, r1
 800238e:	6203      	str	r3, [r0, #32]
 8002390:	4770      	bx	lr
	...

08002394 <uart_write>:
 8002394:	4b04      	ldr	r3, [pc, #16]	; (80023a8 <uart_write+0x14>)
 8002396:	69da      	ldr	r2, [r3, #28]
 8002398:	0612      	lsls	r2, r2, #24
 800239a:	d401      	bmi.n	80023a0 <uart_write+0xc>
 800239c:	bf00      	nop
 800239e:	e7f9      	b.n	8002394 <uart_write>
 80023a0:	b280      	uxth	r0, r0
 80023a2:	8518      	strh	r0, [r3, #40]	; 0x28
 80023a4:	4770      	bx	lr
 80023a6:	bf00      	nop
 80023a8:	40013800 	.word	0x40013800

080023ac <uart_is_char>:
 80023ac:	4b0a      	ldr	r3, [pc, #40]	; (80023d8 <uart_is_char+0x2c>)
 80023ae:	4a0b      	ldr	r2, [pc, #44]	; (80023dc <uart_is_char+0x30>)
 80023b0:	6819      	ldr	r1, [r3, #0]
 80023b2:	6812      	ldr	r2, [r2, #0]
 80023b4:	4291      	cmp	r1, r2
 80023b6:	d00b      	beq.n	80023d0 <uart_is_char+0x24>
 80023b8:	681a      	ldr	r2, [r3, #0]
 80023ba:	4909      	ldr	r1, [pc, #36]	; (80023e0 <uart_is_char+0x34>)
 80023bc:	5c88      	ldrb	r0, [r1, r2]
 80023be:	681a      	ldr	r2, [r3, #0]
 80023c0:	3201      	adds	r2, #1
 80023c2:	601a      	str	r2, [r3, #0]
 80023c4:	681a      	ldr	r2, [r3, #0]
 80023c6:	2a0f      	cmp	r2, #15
 80023c8:	d904      	bls.n	80023d4 <uart_is_char+0x28>
 80023ca:	2200      	movs	r2, #0
 80023cc:	601a      	str	r2, [r3, #0]
 80023ce:	4770      	bx	lr
 80023d0:	f64f 70ff 	movw	r0, #65535	; 0xffff
 80023d4:	4770      	bx	lr
 80023d6:	bf00      	nop
 80023d8:	20000cc0 	.word	0x20000cc0
 80023dc:	20000cbc 	.word	0x20000cbc
 80023e0:	20000cac 	.word	0x20000cac

080023e4 <uart_read>:
 80023e4:	b508      	push	{r3, lr}
 80023e6:	f7ff ffe1 	bl	80023ac <uart_is_char>
 80023ea:	f64f 73ff 	movw	r3, #65535	; 0xffff
 80023ee:	4298      	cmp	r0, r3
 80023f0:	d101      	bne.n	80023f6 <uart_read+0x12>
 80023f2:	bf00      	nop
 80023f4:	e7f7      	b.n	80023e6 <uart_read+0x2>
 80023f6:	b2c0      	uxtb	r0, r0
 80023f8:	bd08      	pop	{r3, pc}
	...

080023fc <uart_init>:
 80023fc:	b530      	push	{r4, r5, lr}
 80023fe:	4b2c      	ldr	r3, [pc, #176]	; (80024b0 <uart_init+0xb4>)
 8002400:	4d2c      	ldr	r5, [pc, #176]	; (80024b4 <uart_init+0xb8>)
 8002402:	2400      	movs	r4, #0
 8002404:	601c      	str	r4, [r3, #0]
 8002406:	4b2c      	ldr	r3, [pc, #176]	; (80024b8 <uart_init+0xbc>)
 8002408:	b08b      	sub	sp, #44	; 0x2c
 800240a:	f44f 3000 	mov.w	r0, #131072	; 0x20000
 800240e:	2101      	movs	r1, #1
 8002410:	601c      	str	r4, [r3, #0]
 8002412:	f7ff fde7 	bl	8001fe4 <RCC_AHBPeriphClockCmd>
 8002416:	f44f 4080 	mov.w	r0, #16384	; 0x4000
 800241a:	2101      	movs	r1, #1
 800241c:	f7ff fdf0 	bl	8002000 <RCC_APB2PeriphClockCmd>
 8002420:	f44f 63c0 	mov.w	r3, #1536	; 0x600
 8002424:	9302      	str	r3, [sp, #8]
 8002426:	2302      	movs	r3, #2
 8002428:	f88d 300c 	strb.w	r3, [sp, #12]
 800242c:	a902      	add	r1, sp, #8
 800242e:	2303      	movs	r3, #3
 8002430:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8002434:	f88d 300d 	strb.w	r3, [sp, #13]
 8002438:	f88d 400e 	strb.w	r4, [sp, #14]
 800243c:	f88d 400f 	strb.w	r4, [sp, #15]
 8002440:	f000 f9dc 	bl	80027fc <GPIO_Init>
 8002444:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8002448:	2109      	movs	r1, #9
 800244a:	2207      	movs	r2, #7
 800244c:	f000 fa20 	bl	8002890 <GPIO_PinAFConfig>
 8002450:	2207      	movs	r2, #7
 8002452:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8002456:	210a      	movs	r1, #10
 8002458:	f000 fa1a 	bl	8002890 <GPIO_PinAFConfig>
 800245c:	f44f 5316 	mov.w	r3, #9600	; 0x2580
 8002460:	9304      	str	r3, [sp, #16]
 8002462:	4628      	mov	r0, r5
 8002464:	230c      	movs	r3, #12
 8002466:	a904      	add	r1, sp, #16
 8002468:	9308      	str	r3, [sp, #32]
 800246a:	9405      	str	r4, [sp, #20]
 800246c:	9406      	str	r4, [sp, #24]
 800246e:	9407      	str	r4, [sp, #28]
 8002470:	9409      	str	r4, [sp, #36]	; 0x24
 8002472:	f7ff fedd 	bl	8002230 <USART_Init>
 8002476:	4628      	mov	r0, r5
 8002478:	2101      	movs	r1, #1
 800247a:	f7ff ff3b 	bl	80022f4 <USART_Cmd>
 800247e:	2201      	movs	r2, #1
 8002480:	4628      	mov	r0, r5
 8002482:	490e      	ldr	r1, [pc, #56]	; (80024bc <uart_init+0xc0>)
 8002484:	f7ff ff46 	bl	8002314 <USART_ITConfig>
 8002488:	2325      	movs	r3, #37	; 0x25
 800248a:	f88d 4005 	strb.w	r4, [sp, #5]
 800248e:	f88d 4006 	strb.w	r4, [sp, #6]
 8002492:	a801      	add	r0, sp, #4
 8002494:	2401      	movs	r4, #1
 8002496:	f88d 3004 	strb.w	r3, [sp, #4]
 800249a:	f88d 4007 	strb.w	r4, [sp, #7]
 800249e:	f7ff fabd 	bl	8001a1c <NVIC_Init>
 80024a2:	4628      	mov	r0, r5
 80024a4:	4621      	mov	r1, r4
 80024a6:	f7ff ff25 	bl	80022f4 <USART_Cmd>
 80024aa:	b00b      	add	sp, #44	; 0x2c
 80024ac:	bd30      	pop	{r4, r5, pc}
 80024ae:	bf00      	nop
 80024b0:	20000cbc 	.word	0x20000cbc
 80024b4:	40013800 	.word	0x40013800
 80024b8:	20000cc0 	.word	0x20000cc0
 80024bc:	00050105 	.word	0x00050105

080024c0 <USART1_IRQHandler>:
 80024c0:	b508      	push	{r3, lr}
 80024c2:	480d      	ldr	r0, [pc, #52]	; (80024f8 <USART1_IRQHandler+0x38>)
 80024c4:	490d      	ldr	r1, [pc, #52]	; (80024fc <USART1_IRQHandler+0x3c>)
 80024c6:	f7ff ff3f 	bl	8002348 <USART_GetITStatus>
 80024ca:	b178      	cbz	r0, 80024ec <USART1_IRQHandler+0x2c>
 80024cc:	480a      	ldr	r0, [pc, #40]	; (80024f8 <USART1_IRQHandler+0x38>)
 80024ce:	f7ff ff1c 	bl	800230a <USART_ReceiveData>
 80024d2:	4b0b      	ldr	r3, [pc, #44]	; (8002500 <USART1_IRQHandler+0x40>)
 80024d4:	490b      	ldr	r1, [pc, #44]	; (8002504 <USART1_IRQHandler+0x44>)
 80024d6:	681a      	ldr	r2, [r3, #0]
 80024d8:	b2c0      	uxtb	r0, r0
 80024da:	5488      	strb	r0, [r1, r2]
 80024dc:	681a      	ldr	r2, [r3, #0]
 80024de:	3201      	adds	r2, #1
 80024e0:	601a      	str	r2, [r3, #0]
 80024e2:	681a      	ldr	r2, [r3, #0]
 80024e4:	2a0f      	cmp	r2, #15
 80024e6:	bf84      	itt	hi
 80024e8:	2200      	movhi	r2, #0
 80024ea:	601a      	strhi	r2, [r3, #0]
 80024ec:	4802      	ldr	r0, [pc, #8]	; (80024f8 <USART1_IRQHandler+0x38>)
 80024ee:	4903      	ldr	r1, [pc, #12]	; (80024fc <USART1_IRQHandler+0x3c>)
 80024f0:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80024f4:	f7ff bf46 	b.w	8002384 <USART_ClearITPendingBit>
 80024f8:	40013800 	.word	0x40013800
 80024fc:	00050105 	.word	0x00050105
 8002500:	20000cbc 	.word	0x20000cbc
 8002504:	20000cac 	.word	0x20000cac

08002508 <uart_clear_buffer>:
 8002508:	b672      	cpsid	i
 800250a:	2300      	movs	r3, #0
 800250c:	4a03      	ldr	r2, [pc, #12]	; (800251c <uart_clear_buffer+0x14>)
 800250e:	2100      	movs	r1, #0
 8002510:	54d1      	strb	r1, [r2, r3]
 8002512:	3301      	adds	r3, #1
 8002514:	2b10      	cmp	r3, #16
 8002516:	d1f9      	bne.n	800250c <uart_clear_buffer+0x4>
 8002518:	b662      	cpsie	i
 800251a:	4770      	bx	lr
 800251c:	20000cac 	.word	0x20000cac

08002520 <Default_Handler>:
 8002520:	4668      	mov	r0, sp
 8002522:	f020 0107 	bic.w	r1, r0, #7
 8002526:	468d      	mov	sp, r1
 8002528:	bf00      	nop
 800252a:	e7fd      	b.n	8002528 <Default_Handler+0x8>

0800252c <HardFault_Handler>:
 800252c:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 8002530:	f000 f8ca 	bl	80026c8 <led_on>
 8002534:	4b06      	ldr	r3, [pc, #24]	; (8002550 <HardFault_Handler+0x24>)
 8002536:	3b01      	subs	r3, #1
 8002538:	d001      	beq.n	800253e <HardFault_Handler+0x12>
 800253a:	bf00      	nop
 800253c:	e7fb      	b.n	8002536 <HardFault_Handler+0xa>
 800253e:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 8002542:	f000 f8d7 	bl	80026f4 <led_off>
 8002546:	4b02      	ldr	r3, [pc, #8]	; (8002550 <HardFault_Handler+0x24>)
 8002548:	3b01      	subs	r3, #1
 800254a:	d0ef      	beq.n	800252c <HardFault_Handler>
 800254c:	bf00      	nop
 800254e:	e7fb      	b.n	8002548 <HardFault_Handler+0x1c>
 8002550:	00989681 	.word	0x00989681

08002554 <_reset_init>:
 8002554:	490e      	ldr	r1, [pc, #56]	; (8002590 <_reset_init+0x3c>)
 8002556:	4b0f      	ldr	r3, [pc, #60]	; (8002594 <_reset_init+0x40>)
 8002558:	1a5b      	subs	r3, r3, r1
 800255a:	109b      	asrs	r3, r3, #2
 800255c:	2200      	movs	r2, #0
 800255e:	429a      	cmp	r2, r3
 8002560:	d006      	beq.n	8002570 <_reset_init+0x1c>
 8002562:	480d      	ldr	r0, [pc, #52]	; (8002598 <_reset_init+0x44>)
 8002564:	f850 0022 	ldr.w	r0, [r0, r2, lsl #2]
 8002568:	f841 0022 	str.w	r0, [r1, r2, lsl #2]
 800256c:	3201      	adds	r2, #1
 800256e:	e7f6      	b.n	800255e <_reset_init+0xa>
 8002570:	4a0a      	ldr	r2, [pc, #40]	; (800259c <_reset_init+0x48>)
 8002572:	f8d2 3088 	ldr.w	r3, [r2, #136]	; 0x88
 8002576:	f443 0370 	orr.w	r3, r3, #15728640	; 0xf00000
 800257a:	f8c2 3088 	str.w	r3, [r2, #136]	; 0x88
 800257e:	f502 720c 	add.w	r2, r2, #560	; 0x230
 8002582:	6853      	ldr	r3, [r2, #4]
 8002584:	f023 4340 	bic.w	r3, r3, #3221225472	; 0xc0000000
 8002588:	6053      	str	r3, [r2, #4]
 800258a:	f7fe bf9b 	b.w	80014c4 <main>
 800258e:	bf00      	nop
 8002590:	20000000 	.word	0x20000000
 8002594:	20000030 	.word	0x20000030
 8002598:	08002ccc 	.word	0x08002ccc
 800259c:	e000ed00 	.word	0xe000ed00

080025a0 <sys_tick_init>:
 80025a0:	4b05      	ldr	r3, [pc, #20]	; (80025b8 <sys_tick_init+0x18>)
 80025a2:	4a06      	ldr	r2, [pc, #24]	; (80025bc <sys_tick_init+0x1c>)
 80025a4:	605a      	str	r2, [r3, #4]
 80025a6:	4a06      	ldr	r2, [pc, #24]	; (80025c0 <sys_tick_init+0x20>)
 80025a8:	21f0      	movs	r1, #240	; 0xf0
 80025aa:	f882 1023 	strb.w	r1, [r2, #35]	; 0x23
 80025ae:	2200      	movs	r2, #0
 80025b0:	609a      	str	r2, [r3, #8]
 80025b2:	2207      	movs	r2, #7
 80025b4:	601a      	str	r2, [r3, #0]
 80025b6:	4770      	bx	lr
 80025b8:	e000e010 	.word	0xe000e010
 80025bc:	00029040 	.word	0x00029040
 80025c0:	e000ed00 	.word	0xe000ed00

080025c4 <sleep>:
 80025c4:	bf30      	wfi
 80025c6:	4770      	bx	lr

080025c8 <sytem_clock_init>:
 80025c8:	f000 b800 	b.w	80025cc <SystemInit>

080025cc <SystemInit>:
 80025cc:	4a39      	ldr	r2, [pc, #228]	; (80026b4 <SystemInit+0xe8>)
 80025ce:	f8d2 3088 	ldr.w	r3, [r2, #136]	; 0x88
 80025d2:	f443 0370 	orr.w	r3, r3, #15728640	; 0xf00000
 80025d6:	f8c2 3088 	str.w	r3, [r2, #136]	; 0x88
 80025da:	4b37      	ldr	r3, [pc, #220]	; (80026b8 <SystemInit+0xec>)
 80025dc:	681a      	ldr	r2, [r3, #0]
 80025de:	f042 0201 	orr.w	r2, r2, #1
 80025e2:	601a      	str	r2, [r3, #0]
 80025e4:	6859      	ldr	r1, [r3, #4]
 80025e6:	4a35      	ldr	r2, [pc, #212]	; (80026bc <SystemInit+0xf0>)
 80025e8:	400a      	ands	r2, r1
 80025ea:	605a      	str	r2, [r3, #4]
 80025ec:	681a      	ldr	r2, [r3, #0]
 80025ee:	f022 7284 	bic.w	r2, r2, #17301504	; 0x1080000
 80025f2:	f422 3280 	bic.w	r2, r2, #65536	; 0x10000
 80025f6:	601a      	str	r2, [r3, #0]
 80025f8:	681a      	ldr	r2, [r3, #0]
 80025fa:	f422 2280 	bic.w	r2, r2, #262144	; 0x40000
 80025fe:	601a      	str	r2, [r3, #0]
 8002600:	685a      	ldr	r2, [r3, #4]
 8002602:	f422 02fe 	bic.w	r2, r2, #8323072	; 0x7f0000
 8002606:	605a      	str	r2, [r3, #4]
 8002608:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 800260a:	f022 020f 	bic.w	r2, r2, #15
 800260e:	62da      	str	r2, [r3, #44]	; 0x2c
 8002610:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8002612:	4a2b      	ldr	r2, [pc, #172]	; (80026c0 <SystemInit+0xf4>)
 8002614:	b082      	sub	sp, #8
 8002616:	400a      	ands	r2, r1
 8002618:	631a      	str	r2, [r3, #48]	; 0x30
 800261a:	2200      	movs	r2, #0
 800261c:	609a      	str	r2, [r3, #8]
 800261e:	9200      	str	r2, [sp, #0]
 8002620:	9201      	str	r2, [sp, #4]
 8002622:	681a      	ldr	r2, [r3, #0]
 8002624:	f442 3280 	orr.w	r2, r2, #65536	; 0x10000
 8002628:	601a      	str	r2, [r3, #0]
 800262a:	681a      	ldr	r2, [r3, #0]
 800262c:	f402 3200 	and.w	r2, r2, #131072	; 0x20000
 8002630:	9201      	str	r2, [sp, #4]
 8002632:	9a00      	ldr	r2, [sp, #0]
 8002634:	3201      	adds	r2, #1
 8002636:	9200      	str	r2, [sp, #0]
 8002638:	9a01      	ldr	r2, [sp, #4]
 800263a:	b91a      	cbnz	r2, 8002644 <SystemInit+0x78>
 800263c:	9a00      	ldr	r2, [sp, #0]
 800263e:	f5b2 4fa0 	cmp.w	r2, #20480	; 0x5000
 8002642:	d1f2      	bne.n	800262a <SystemInit+0x5e>
 8002644:	681a      	ldr	r2, [r3, #0]
 8002646:	f412 3200 	ands.w	r2, r2, #131072	; 0x20000
 800264a:	bf18      	it	ne
 800264c:	2201      	movne	r2, #1
 800264e:	9201      	str	r2, [sp, #4]
 8002650:	9a01      	ldr	r2, [sp, #4]
 8002652:	2a01      	cmp	r2, #1
 8002654:	d005      	beq.n	8002662 <SystemInit+0x96>
 8002656:	4b17      	ldr	r3, [pc, #92]	; (80026b4 <SystemInit+0xe8>)
 8002658:	f04f 6200 	mov.w	r2, #134217728	; 0x8000000
 800265c:	609a      	str	r2, [r3, #8]
 800265e:	b002      	add	sp, #8
 8002660:	4770      	bx	lr
 8002662:	4a18      	ldr	r2, [pc, #96]	; (80026c4 <SystemInit+0xf8>)
 8002664:	2112      	movs	r1, #18
 8002666:	6011      	str	r1, [r2, #0]
 8002668:	685a      	ldr	r2, [r3, #4]
 800266a:	605a      	str	r2, [r3, #4]
 800266c:	685a      	ldr	r2, [r3, #4]
 800266e:	605a      	str	r2, [r3, #4]
 8002670:	685a      	ldr	r2, [r3, #4]
 8002672:	f442 6280 	orr.w	r2, r2, #1024	; 0x400
 8002676:	605a      	str	r2, [r3, #4]
 8002678:	685a      	ldr	r2, [r3, #4]
 800267a:	f422 127c 	bic.w	r2, r2, #4128768	; 0x3f0000
 800267e:	605a      	str	r2, [r3, #4]
 8002680:	685a      	ldr	r2, [r3, #4]
 8002682:	f442 12e8 	orr.w	r2, r2, #1900544	; 0x1d0000
 8002686:	605a      	str	r2, [r3, #4]
 8002688:	681a      	ldr	r2, [r3, #0]
 800268a:	f042 7280 	orr.w	r2, r2, #16777216	; 0x1000000
 800268e:	601a      	str	r2, [r3, #0]
 8002690:	6819      	ldr	r1, [r3, #0]
 8002692:	4a09      	ldr	r2, [pc, #36]	; (80026b8 <SystemInit+0xec>)
 8002694:	0189      	lsls	r1, r1, #6
 8002696:	d5fb      	bpl.n	8002690 <SystemInit+0xc4>
 8002698:	6851      	ldr	r1, [r2, #4]
 800269a:	f021 0103 	bic.w	r1, r1, #3
 800269e:	6051      	str	r1, [r2, #4]
 80026a0:	6851      	ldr	r1, [r2, #4]
 80026a2:	f041 0102 	orr.w	r1, r1, #2
 80026a6:	6051      	str	r1, [r2, #4]
 80026a8:	685a      	ldr	r2, [r3, #4]
 80026aa:	f002 020c 	and.w	r2, r2, #12
 80026ae:	2a08      	cmp	r2, #8
 80026b0:	d1fa      	bne.n	80026a8 <SystemInit+0xdc>
 80026b2:	e7d0      	b.n	8002656 <SystemInit+0x8a>
 80026b4:	e000ed00 	.word	0xe000ed00
 80026b8:	40021000 	.word	0x40021000
 80026bc:	f87fc00c 	.word	0xf87fc00c
 80026c0:	ff00fccc 	.word	0xff00fccc
 80026c4:	40022000 	.word	0x40022000

080026c8 <led_on>:
 80026c8:	0401      	lsls	r1, r0, #16
 80026ca:	bf42      	ittt	mi
 80026cc:	4b08      	ldrmi	r3, [pc, #32]	; (80026f0 <led_on+0x28>)
 80026ce:	f44f 4200 	movmi.w	r2, #32768	; 0x8000
 80026d2:	619a      	strmi	r2, [r3, #24]
 80026d4:	0702      	lsls	r2, r0, #28
 80026d6:	bf42      	ittt	mi
 80026d8:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 80026dc:	2208      	movmi	r2, #8
 80026de:	851a      	strhmi	r2, [r3, #40]	; 0x28
 80026e0:	07c3      	lsls	r3, r0, #31
 80026e2:	bf42      	ittt	mi
 80026e4:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 80026e8:	2201      	movmi	r2, #1
 80026ea:	619a      	strmi	r2, [r3, #24]
 80026ec:	4770      	bx	lr
 80026ee:	bf00      	nop
 80026f0:	48000400 	.word	0x48000400

080026f4 <led_off>:
 80026f4:	0401      	lsls	r1, r0, #16
 80026f6:	bf42      	ittt	mi
 80026f8:	4b08      	ldrmi	r3, [pc, #32]	; (800271c <led_off+0x28>)
 80026fa:	f44f 4200 	movmi.w	r2, #32768	; 0x8000
 80026fe:	851a      	strhmi	r2, [r3, #40]	; 0x28
 8002700:	0702      	lsls	r2, r0, #28
 8002702:	bf42      	ittt	mi
 8002704:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 8002708:	2208      	movmi	r2, #8
 800270a:	619a      	strmi	r2, [r3, #24]
 800270c:	07c3      	lsls	r3, r0, #31
 800270e:	bf42      	ittt	mi
 8002710:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 8002714:	2201      	movmi	r2, #1
 8002716:	851a      	strhmi	r2, [r3, #40]	; 0x28
 8002718:	4770      	bx	lr
 800271a:	bf00      	nop
 800271c:	48000400 	.word	0x48000400

08002720 <gpio_init>:
 8002720:	e92d 41f3 	stmdb	sp!, {r0, r1, r4, r5, r6, r7, r8, lr}
 8002724:	f44f 3000 	mov.w	r0, #131072	; 0x20000
 8002728:	2101      	movs	r1, #1
 800272a:	f7ff fc5b 	bl	8001fe4 <RCC_AHBPeriphClockCmd>
 800272e:	f44f 2080 	mov.w	r0, #262144	; 0x40000
 8002732:	2101      	movs	r1, #1
 8002734:	f7ff fc56 	bl	8001fe4 <RCC_AHBPeriphClockCmd>
 8002738:	f44f 2000 	mov.w	r0, #524288	; 0x80000
 800273c:	2101      	movs	r1, #1
 800273e:	f7ff fc51 	bl	8001fe4 <RCC_AHBPeriphClockCmd>
 8002742:	2400      	movs	r4, #0
 8002744:	2501      	movs	r5, #1
 8002746:	2603      	movs	r6, #3
 8002748:	f44f 4800 	mov.w	r8, #32768	; 0x8000
 800274c:	4826      	ldr	r0, [pc, #152]	; (80027e8 <gpio_init+0xc8>)
 800274e:	f8cd 8000 	str.w	r8, [sp]
 8002752:	4669      	mov	r1, sp
 8002754:	2708      	movs	r7, #8
 8002756:	f88d 5004 	strb.w	r5, [sp, #4]
 800275a:	f88d 4006 	strb.w	r4, [sp, #6]
 800275e:	f88d 6005 	strb.w	r6, [sp, #5]
 8002762:	f88d 4007 	strb.w	r4, [sp, #7]
 8002766:	f000 f849 	bl	80027fc <GPIO_Init>
 800276a:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 800276e:	4669      	mov	r1, sp
 8002770:	9700      	str	r7, [sp, #0]
 8002772:	f88d 5004 	strb.w	r5, [sp, #4]
 8002776:	f88d 4006 	strb.w	r4, [sp, #6]
 800277a:	f88d 6005 	strb.w	r6, [sp, #5]
 800277e:	f88d 4007 	strb.w	r4, [sp, #7]
 8002782:	f000 f83b 	bl	80027fc <GPIO_Init>
 8002786:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 800278a:	4669      	mov	r1, sp
 800278c:	9500      	str	r5, [sp, #0]
 800278e:	f88d 5004 	strb.w	r5, [sp, #4]
 8002792:	f88d 4006 	strb.w	r4, [sp, #6]
 8002796:	f88d 6005 	strb.w	r6, [sp, #5]
 800279a:	f88d 4007 	strb.w	r4, [sp, #7]
 800279e:	f000 f82d 	bl	80027fc <GPIO_Init>
 80027a2:	f44f 7300 	mov.w	r3, #512	; 0x200
 80027a6:	4669      	mov	r1, sp
 80027a8:	480f      	ldr	r0, [pc, #60]	; (80027e8 <gpio_init+0xc8>)
 80027aa:	9300      	str	r3, [sp, #0]
 80027ac:	f88d 4004 	strb.w	r4, [sp, #4]
 80027b0:	f88d 6005 	strb.w	r6, [sp, #5]
 80027b4:	f88d 4007 	strb.w	r4, [sp, #7]
 80027b8:	f000 f820 	bl	80027fc <GPIO_Init>
 80027bc:	4640      	mov	r0, r8
 80027be:	f7ff ff83 	bl	80026c8 <led_on>
 80027c2:	4638      	mov	r0, r7
 80027c4:	f7ff ff96 	bl	80026f4 <led_off>
 80027c8:	4628      	mov	r0, r5
 80027ca:	f7ff ff93 	bl	80026f4 <led_off>
 80027ce:	f242 7311 	movw	r3, #10001	; 0x2711
 80027d2:	3b01      	subs	r3, #1
 80027d4:	d001      	beq.n	80027da <gpio_init+0xba>
 80027d6:	bf00      	nop
 80027d8:	e7fb      	b.n	80027d2 <gpio_init+0xb2>
 80027da:	2001      	movs	r0, #1
 80027dc:	f7ff ff74 	bl	80026c8 <led_on>
 80027e0:	b002      	add	sp, #8
 80027e2:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 80027e6:	bf00      	nop
 80027e8:	48000400 	.word	0x48000400

080027ec <get_key>:
 80027ec:	4b02      	ldr	r3, [pc, #8]	; (80027f8 <get_key+0xc>)
 80027ee:	8a18      	ldrh	r0, [r3, #16]
 80027f0:	43c0      	mvns	r0, r0
 80027f2:	f400 7000 	and.w	r0, r0, #512	; 0x200
 80027f6:	4770      	bx	lr
 80027f8:	48000400 	.word	0x48000400

080027fc <GPIO_Init>:
 80027fc:	b5f0      	push	{r4, r5, r6, r7, lr}
 80027fe:	bf00      	nop
 8002800:	bf00      	nop
 8002802:	bf00      	nop
 8002804:	bf00      	nop
 8002806:	2300      	movs	r3, #0
 8002808:	680e      	ldr	r6, [r1, #0]
 800280a:	461c      	mov	r4, r3
 800280c:	2501      	movs	r5, #1
 800280e:	40a5      	lsls	r5, r4
 8002810:	ea05 0e06 	and.w	lr, r5, r6
 8002814:	45ae      	cmp	lr, r5
 8002816:	d12d      	bne.n	8002874 <GPIO_Init+0x78>
 8002818:	790f      	ldrb	r7, [r1, #4]
 800281a:	1e7a      	subs	r2, r7, #1
 800281c:	2a01      	cmp	r2, #1
 800281e:	d817      	bhi.n	8002850 <GPIO_Init+0x54>
 8002820:	bf00      	nop
 8002822:	2203      	movs	r2, #3
 8002824:	6885      	ldr	r5, [r0, #8]
 8002826:	409a      	lsls	r2, r3
 8002828:	ea25 0202 	bic.w	r2, r5, r2
 800282c:	6082      	str	r2, [r0, #8]
 800282e:	794d      	ldrb	r5, [r1, #5]
 8002830:	6882      	ldr	r2, [r0, #8]
 8002832:	409d      	lsls	r5, r3
 8002834:	4315      	orrs	r5, r2
 8002836:	6085      	str	r5, [r0, #8]
 8002838:	bf00      	nop
 800283a:	8882      	ldrh	r2, [r0, #4]
 800283c:	b292      	uxth	r2, r2
 800283e:	ea22 020e 	bic.w	r2, r2, lr
 8002842:	8082      	strh	r2, [r0, #4]
 8002844:	798a      	ldrb	r2, [r1, #6]
 8002846:	8885      	ldrh	r5, [r0, #4]
 8002848:	40a2      	lsls	r2, r4
 800284a:	432a      	orrs	r2, r5
 800284c:	b292      	uxth	r2, r2
 800284e:	8082      	strh	r2, [r0, #4]
 8002850:	2203      	movs	r2, #3
 8002852:	6805      	ldr	r5, [r0, #0]
 8002854:	409a      	lsls	r2, r3
 8002856:	43d2      	mvns	r2, r2
 8002858:	4015      	ands	r5, r2
 800285a:	6005      	str	r5, [r0, #0]
 800285c:	6805      	ldr	r5, [r0, #0]
 800285e:	409f      	lsls	r7, r3
 8002860:	432f      	orrs	r7, r5
 8002862:	6007      	str	r7, [r0, #0]
 8002864:	68c7      	ldr	r7, [r0, #12]
 8002866:	4017      	ands	r7, r2
 8002868:	79ca      	ldrb	r2, [r1, #7]
 800286a:	fa02 f503 	lsl.w	r5, r2, r3
 800286e:	ea47 0205 	orr.w	r2, r7, r5
 8002872:	60c2      	str	r2, [r0, #12]
 8002874:	3401      	adds	r4, #1
 8002876:	2c10      	cmp	r4, #16
 8002878:	f103 0302 	add.w	r3, r3, #2
 800287c:	d1c6      	bne.n	800280c <GPIO_Init+0x10>
 800287e:	bdf0      	pop	{r4, r5, r6, r7, pc}

08002880 <GPIO_SetBits>:
 8002880:	bf00      	nop
 8002882:	bf00      	nop
 8002884:	6181      	str	r1, [r0, #24]
 8002886:	4770      	bx	lr

08002888 <GPIO_ResetBits>:
 8002888:	bf00      	nop
 800288a:	bf00      	nop
 800288c:	8501      	strh	r1, [r0, #40]	; 0x28
 800288e:	4770      	bx	lr

08002890 <GPIO_PinAFConfig>:
 8002890:	b510      	push	{r4, lr}
 8002892:	bf00      	nop
 8002894:	bf00      	nop
 8002896:	bf00      	nop
 8002898:	f001 0307 	and.w	r3, r1, #7
 800289c:	08c9      	lsrs	r1, r1, #3
 800289e:	eb00 0081 	add.w	r0, r0, r1, lsl #2
 80028a2:	009b      	lsls	r3, r3, #2
 80028a4:	6a04      	ldr	r4, [r0, #32]
 80028a6:	210f      	movs	r1, #15
 80028a8:	4099      	lsls	r1, r3
 80028aa:	ea24 0101 	bic.w	r1, r4, r1
 80028ae:	6201      	str	r1, [r0, #32]
 80028b0:	6a01      	ldr	r1, [r0, #32]
 80028b2:	409a      	lsls	r2, r3
 80028b4:	430a      	orrs	r2, r1
 80028b6:	6202      	str	r2, [r0, #32]
 80028b8:	bd10      	pop	{r4, pc}

080028ba <i2c_delay>:
 80028ba:	230b      	movs	r3, #11
 80028bc:	3b01      	subs	r3, #1
 80028be:	d001      	beq.n	80028c4 <i2c_delay+0xa>
 80028c0:	bf00      	nop
 80028c2:	e7fb      	b.n	80028bc <i2c_delay+0x2>
 80028c4:	4770      	bx	lr
	...

080028c8 <SetLowSDA>:
 80028c8:	b537      	push	{r0, r1, r2, r4, r5, lr}
 80028ca:	4d0d      	ldr	r5, [pc, #52]	; (8002900 <SetLowSDA+0x38>)
 80028cc:	2301      	movs	r3, #1
 80028ce:	2203      	movs	r2, #3
 80028d0:	2480      	movs	r4, #128	; 0x80
 80028d2:	f88d 3004 	strb.w	r3, [sp, #4]
 80028d6:	f88d 3006 	strb.w	r3, [sp, #6]
 80028da:	4628      	mov	r0, r5
 80028dc:	2300      	movs	r3, #0
 80028de:	4669      	mov	r1, sp
 80028e0:	f88d 2005 	strb.w	r2, [sp, #5]
 80028e4:	f88d 3007 	strb.w	r3, [sp, #7]
 80028e8:	9400      	str	r4, [sp, #0]
 80028ea:	f7ff ff87 	bl	80027fc <GPIO_Init>
 80028ee:	4628      	mov	r0, r5
 80028f0:	4621      	mov	r1, r4
 80028f2:	f7ff ffc9 	bl	8002888 <GPIO_ResetBits>
 80028f6:	f7ff ffe0 	bl	80028ba <i2c_delay>
 80028fa:	b003      	add	sp, #12
 80028fc:	bd30      	pop	{r4, r5, pc}
 80028fe:	bf00      	nop
 8002900:	48000400 	.word	0x48000400

08002904 <SetHighSDA>:
 8002904:	b537      	push	{r0, r1, r2, r4, r5, lr}
 8002906:	4d0d      	ldr	r5, [pc, #52]	; (800293c <SetHighSDA+0x38>)
 8002908:	2203      	movs	r2, #3
 800290a:	2300      	movs	r3, #0
 800290c:	2480      	movs	r4, #128	; 0x80
 800290e:	f88d 2005 	strb.w	r2, [sp, #5]
 8002912:	4628      	mov	r0, r5
 8002914:	2201      	movs	r2, #1
 8002916:	4669      	mov	r1, sp
 8002918:	f88d 3004 	strb.w	r3, [sp, #4]
 800291c:	f88d 2006 	strb.w	r2, [sp, #6]
 8002920:	f88d 3007 	strb.w	r3, [sp, #7]
 8002924:	9400      	str	r4, [sp, #0]
 8002926:	f7ff ff69 	bl	80027fc <GPIO_Init>
 800292a:	4628      	mov	r0, r5
 800292c:	4621      	mov	r1, r4
 800292e:	f7ff ffa7 	bl	8002880 <GPIO_SetBits>
 8002932:	f7ff ffc2 	bl	80028ba <i2c_delay>
 8002936:	b003      	add	sp, #12
 8002938:	bd30      	pop	{r4, r5, pc}
 800293a:	bf00      	nop
 800293c:	48000400 	.word	0x48000400

08002940 <SetLowSCL>:
 8002940:	b508      	push	{r3, lr}
 8002942:	4804      	ldr	r0, [pc, #16]	; (8002954 <SetLowSCL+0x14>)
 8002944:	2140      	movs	r1, #64	; 0x40
 8002946:	f7ff ff9f 	bl	8002888 <GPIO_ResetBits>
 800294a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 800294e:	f7ff bfb4 	b.w	80028ba <i2c_delay>
 8002952:	bf00      	nop
 8002954:	48000400 	.word	0x48000400

08002958 <SetHighSCL>:
 8002958:	b508      	push	{r3, lr}
 800295a:	4804      	ldr	r0, [pc, #16]	; (800296c <SetHighSCL+0x14>)
 800295c:	2140      	movs	r1, #64	; 0x40
 800295e:	f7ff ff8f 	bl	8002880 <GPIO_SetBits>
 8002962:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8002966:	f7ff bfa8 	b.w	80028ba <i2c_delay>
 800296a:	bf00      	nop
 800296c:	48000400 	.word	0x48000400

08002970 <i2c_0_init>:
 8002970:	b507      	push	{r0, r1, r2, lr}
 8002972:	f44f 2080 	mov.w	r0, #262144	; 0x40000
 8002976:	2101      	movs	r1, #1
 8002978:	f7ff fb34 	bl	8001fe4 <RCC_AHBPeriphClockCmd>
 800297c:	23c0      	movs	r3, #192	; 0xc0
 800297e:	9300      	str	r3, [sp, #0]
 8002980:	2301      	movs	r3, #1
 8002982:	2203      	movs	r2, #3
 8002984:	480a      	ldr	r0, [pc, #40]	; (80029b0 <i2c_0_init+0x40>)
 8002986:	f88d 3004 	strb.w	r3, [sp, #4]
 800298a:	4669      	mov	r1, sp
 800298c:	f88d 3006 	strb.w	r3, [sp, #6]
 8002990:	2300      	movs	r3, #0
 8002992:	f88d 2005 	strb.w	r2, [sp, #5]
 8002996:	f88d 3007 	strb.w	r3, [sp, #7]
 800299a:	f7ff ff2f 	bl	80027fc <GPIO_Init>
 800299e:	f7ff ffdb 	bl	8002958 <SetHighSCL>
 80029a2:	f7ff ff91 	bl	80028c8 <SetLowSDA>
 80029a6:	f7ff ffad 	bl	8002904 <SetHighSDA>
 80029aa:	b003      	add	sp, #12
 80029ac:	f85d fb04 	ldr.w	pc, [sp], #4
 80029b0:	48000400 	.word	0x48000400

080029b4 <i2cStart>:
 80029b4:	b508      	push	{r3, lr}
 80029b6:	f7ff ffcf 	bl	8002958 <SetHighSCL>
 80029ba:	f7ff ffa3 	bl	8002904 <SetHighSDA>
 80029be:	f7ff ffcb 	bl	8002958 <SetHighSCL>
 80029c2:	f7ff ff81 	bl	80028c8 <SetLowSDA>
 80029c6:	f7ff ffbb 	bl	8002940 <SetLowSCL>
 80029ca:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80029ce:	f7ff bf99 	b.w	8002904 <SetHighSDA>

080029d2 <i2cStop>:
 80029d2:	b508      	push	{r3, lr}
 80029d4:	f7ff ffb4 	bl	8002940 <SetLowSCL>
 80029d8:	f7ff ff76 	bl	80028c8 <SetLowSDA>
 80029dc:	f7ff ffbc 	bl	8002958 <SetHighSCL>
 80029e0:	f7ff ff72 	bl	80028c8 <SetLowSDA>
 80029e4:	f7ff ffb8 	bl	8002958 <SetHighSCL>
 80029e8:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80029ec:	f7ff bf8a 	b.w	8002904 <SetHighSDA>

080029f0 <i2cWrite>:
 80029f0:	b538      	push	{r3, r4, r5, lr}
 80029f2:	4605      	mov	r5, r0
 80029f4:	2408      	movs	r4, #8
 80029f6:	f7ff ffa3 	bl	8002940 <SetLowSCL>
 80029fa:	062b      	lsls	r3, r5, #24
 80029fc:	d502      	bpl.n	8002a04 <i2cWrite+0x14>
 80029fe:	f7ff ff81 	bl	8002904 <SetHighSDA>
 8002a02:	e001      	b.n	8002a08 <i2cWrite+0x18>
 8002a04:	f7ff ff60 	bl	80028c8 <SetLowSDA>
 8002a08:	3c01      	subs	r4, #1
 8002a0a:	f7ff ffa5 	bl	8002958 <SetHighSCL>
 8002a0e:	006d      	lsls	r5, r5, #1
 8002a10:	f014 04ff 	ands.w	r4, r4, #255	; 0xff
 8002a14:	b2ed      	uxtb	r5, r5
 8002a16:	d1ee      	bne.n	80029f6 <i2cWrite+0x6>
 8002a18:	f7ff ff92 	bl	8002940 <SetLowSCL>
 8002a1c:	f7ff ff72 	bl	8002904 <SetHighSDA>
 8002a20:	f7ff ff9a 	bl	8002958 <SetHighSCL>
 8002a24:	4b05      	ldr	r3, [pc, #20]	; (8002a3c <i2cWrite+0x4c>)
 8002a26:	8a1c      	ldrh	r4, [r3, #16]
 8002a28:	b2a4      	uxth	r4, r4
 8002a2a:	f7ff ff89 	bl	8002940 <SetLowSCL>
 8002a2e:	f7ff ff44 	bl	80028ba <i2c_delay>
 8002a32:	f084 0080 	eor.w	r0, r4, #128	; 0x80
 8002a36:	f3c0 10c0 	ubfx	r0, r0, #7, #1
 8002a3a:	bd38      	pop	{r3, r4, r5, pc}
 8002a3c:	48000400 	.word	0x48000400

08002a40 <i2cRead>:
 8002a40:	b570      	push	{r4, r5, r6, lr}
 8002a42:	4606      	mov	r6, r0
 8002a44:	f7ff ff7c 	bl	8002940 <SetLowSCL>
 8002a48:	f7ff ff5c 	bl	8002904 <SetHighSDA>
 8002a4c:	2508      	movs	r5, #8
 8002a4e:	2400      	movs	r4, #0
 8002a50:	f7ff ff82 	bl	8002958 <SetHighSCL>
 8002a54:	4b0d      	ldr	r3, [pc, #52]	; (8002a8c <i2cRead+0x4c>)
 8002a56:	8a1b      	ldrh	r3, [r3, #16]
 8002a58:	0064      	lsls	r4, r4, #1
 8002a5a:	061b      	lsls	r3, r3, #24
 8002a5c:	b2e4      	uxtb	r4, r4
 8002a5e:	bf48      	it	mi
 8002a60:	3401      	addmi	r4, #1
 8002a62:	f105 35ff 	add.w	r5, r5, #4294967295	; 0xffffffff
 8002a66:	bf48      	it	mi
 8002a68:	b2e4      	uxtbmi	r4, r4
 8002a6a:	f7ff ff69 	bl	8002940 <SetLowSCL>
 8002a6e:	f015 05ff 	ands.w	r5, r5, #255	; 0xff
 8002a72:	d1ed      	bne.n	8002a50 <i2cRead+0x10>
 8002a74:	b10e      	cbz	r6, 8002a7a <i2cRead+0x3a>
 8002a76:	f7ff ff27 	bl	80028c8 <SetLowSDA>
 8002a7a:	f7ff ff6d 	bl	8002958 <SetHighSCL>
 8002a7e:	f7ff ff5f 	bl	8002940 <SetLowSCL>
 8002a82:	f7ff ff1a 	bl	80028ba <i2c_delay>
 8002a86:	4620      	mov	r0, r4
 8002a88:	bd70      	pop	{r4, r5, r6, pc}
 8002a8a:	bf00      	nop
 8002a8c:	48000400 	.word	0x48000400

08002a90 <i2c_write_reg>:
 8002a90:	b570      	push	{r4, r5, r6, lr}
 8002a92:	4606      	mov	r6, r0
 8002a94:	460d      	mov	r5, r1
 8002a96:	4614      	mov	r4, r2
 8002a98:	f7ff ff8c 	bl	80029b4 <i2cStart>
 8002a9c:	4630      	mov	r0, r6
 8002a9e:	f7ff ffa7 	bl	80029f0 <i2cWrite>
 8002aa2:	4628      	mov	r0, r5
 8002aa4:	f7ff ffa4 	bl	80029f0 <i2cWrite>
 8002aa8:	4620      	mov	r0, r4
 8002aaa:	f7ff ffa1 	bl	80029f0 <i2cWrite>
 8002aae:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 8002ab2:	f7ff bf8e 	b.w	80029d2 <i2cStop>

08002ab6 <i2c_read_reg>:
 8002ab6:	b538      	push	{r3, r4, r5, lr}
 8002ab8:	4604      	mov	r4, r0
 8002aba:	460d      	mov	r5, r1
 8002abc:	f7ff ff7a 	bl	80029b4 <i2cStart>
 8002ac0:	4620      	mov	r0, r4
 8002ac2:	f7ff ff95 	bl	80029f0 <i2cWrite>
 8002ac6:	4628      	mov	r0, r5
 8002ac8:	f7ff ff92 	bl	80029f0 <i2cWrite>
 8002acc:	f7ff ff72 	bl	80029b4 <i2cStart>
 8002ad0:	f044 0001 	orr.w	r0, r4, #1
 8002ad4:	f7ff ff8c 	bl	80029f0 <i2cWrite>
 8002ad8:	2000      	movs	r0, #0
 8002ada:	f7ff ffb1 	bl	8002a40 <i2cRead>
 8002ade:	4604      	mov	r4, r0
 8002ae0:	f7ff ff77 	bl	80029d2 <i2cStop>
 8002ae4:	4620      	mov	r0, r4
 8002ae6:	bd38      	pop	{r3, r4, r5, pc}

08002ae8 <_init>:
 8002ae8:	e1a0c00d 	mov	ip, sp
 8002aec:	e92ddff8 	push	{r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
 8002af0:	e24cb004 	sub	fp, ip, #4
 8002af4:	e24bd028 	sub	sp, fp, #40	; 0x28
 8002af8:	e89d6ff0 	ldm	sp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
 8002afc:	e12fff1e 	bx	lr

08002b00 <_fini>:
 8002b00:	e1a0c00d 	mov	ip, sp
 8002b04:	e92ddff8 	push	{r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
 8002b08:	e24cb004 	sub	fp, ip, #4
 8002b0c:	e24bd028 	sub	sp, fp, #40	; 0x28
 8002b10:	e89d6ff0 	ldm	sp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
 8002b14:	e12fff1e 	bx	lr
 8002b18:	00000020 	.word	0x00000020
 8002b1c:	00000040 	.word	0x00000040
 8002b20:	00000060 	.word	0x00000060
 8002b24:	00000080 	.word	0x00000080
 8002b28:	432b5441 	.word	0x432b5441
 8002b2c:	554d5049 	.word	0x554d5049
 8002b30:	0d313d58 	.word	0x0d313d58
 8002b34:	5441000a 	.word	0x5441000a
 8002b38:	5049432b 	.word	0x5049432b
 8002b3c:	3d58554d 	.word	0x3d58554d
 8002b40:	000a0d30 	.word	0x000a0d30
 8002b44:	432b5441 	.word	0x432b5441
 8002b48:	444f4d57 	.word	0x444f4d57
 8002b4c:	0d313d45 	.word	0x0d313d45
 8002b50:	5441000a 	.word	0x5441000a
 8002b54:	4a57432b 	.word	0x4a57432b
 8002b58:	223d5041 	.word	0x223d5041
 8002b5c:	72656100 	.word	0x72656100
 8002b60:	61007369 	.word	0x61007369
 8002b64:	65646362 	.word	0x65646362
 8002b68:	00686766 	.word	0x00686766
 8002b6c:	000a0d22 	.word	0x000a0d22
 8002b70:	432b5441 	.word	0x432b5441
 8002b74:	45535049 	.word	0x45535049
 8002b78:	52455652 	.word	0x52455652
 8002b7c:	382c313d 	.word	0x382c313d
 8002b80:	000a0d30 	.word	0x000a0d30
 8002b84:	432b5441 	.word	0x432b5441
 8002b88:	4c435049 	.word	0x4c435049
 8002b8c:	0d45534f 	.word	0x0d45534f
 8002b90:	5441000a 	.word	0x5441000a
 8002b94:	5049432b 	.word	0x5049432b
 8002b98:	52415453 	.word	0x52415453
 8002b9c:	54223d54 	.word	0x54223d54
 8002ba0:	2c225043 	.word	0x2c225043
 8002ba4:	2c220022 	.word	0x2c220022
 8002ba8:	4e4f4300 	.word	0x4e4f4300
 8002bac:	5443454e 	.word	0x5443454e
 8002bb0:	2b544100 	.word	0x2b544100
 8002bb4:	53504943 	.word	0x53504943
 8002bb8:	3d444e45 	.word	0x3d444e45
 8002bbc:	53003e00 	.word	0x53003e00
 8002bc0:	20444e45 	.word	0x20444e45
 8002bc4:	2b004b4f 	.word	0x2b004b4f
 8002bc8:	2c445049 	.word	0x2c445049
 8002bcc:	32393100 	.word	0x32393100
 8002bd0:	3836312e 	.word	0x3836312e
 8002bd4:	2e33342e 	.word	0x2e33342e
 8002bd8:	00373531 	.word	0x00373531
 8002bdc:	69647473 	.word	0x69647473
 8002be0:	6e69206f 	.word	0x6e69206f
 8002be4:	64207469 	.word	0x64207469
 8002be8:	0a656e6f 	.word	0x0a656e6f
 8002bec:	00          	.byte	0x00
 8002bed:	65          	.byte	0x65
 8002bee:	7272      	.short	0x7272
 8002bf0:	6320726f 	.word	0x6320726f
 8002bf4:	2065646f 	.word	0x2065646f
 8002bf8:	253a7525 	.word	0x253a7525
 8002bfc:	0a75      	.short	0x0a75
 8002bfe:	00          	.byte	0x00
 8002bff:	4c          	.byte	0x4c
 8002c00:	44394d53 	.word	0x44394d53
 8002c04:	3a203053 	.word	0x3a203053
 8002c08:	69250020 	.word	0x69250020
 8002c0c:	20692520 	.word	0x20692520
 8002c10:	2c206925 	.word	0x2c206925
 8002c14:	69250020 	.word	0x69250020
 8002c18:	20692520 	.word	0x20692520
 8002c1c:	0a006925 	.word	0x0a006925
 8002c20:	20424752 	.word	0x20424752
 8002c24:	66727573 	.word	0x66727573
 8002c28:	20656361 	.word	0x20656361
 8002c2c:	0a00203a 	.word	0x0a00203a
 8002c30:	00203a52 	.word	0x00203a52
 8002c34:	00206925 	.word	0x00206925
 8002c38:	203a470a 	.word	0x203a470a
 8002c3c:	3a420a00 	.word	0x3a420a00
 8002c40:	0a0a0020 	.word	0x0a0a0020
 8002c44:	20692500 	.word	0x20692500
 8002c48:	25206925 	.word	0x25206925
 8002c4c:	0d000a69 	.word	0x0d000a69
 8002c50:	4332490a 	.word	0x4332490a
 8002c54:	4344415f 	.word	0x4344415f
 8002c58:	0a0d003a 	.word	0x0a0d003a
 8002c5c:	5f434441 	.word	0x5f434441
 8002c60:	3a544142 	.word	0x3a544142
 8002c64:	00          	.byte	0x00
 8002c65:	0a          	.byte	0x0a
 8002c66:	6577      	.short	0x6577
 8002c68:	6d6f636c 	.word	0x6d6f636c
 8002c6c:	6f742065 	.word	0x6f742065
 8002c70:	7a755320 	.word	0x7a755320
 8002c74:	4f616875 	.word	0x4f616875
 8002c78:	5f5e2053 	.word	0x5f5e2053
 8002c7c:	2e32205e 	.word	0x2e32205e
 8002c80:	0a362e30 	.word	0x0a362e30
 8002c84:	4c495542 	.word	0x4c495542
 8002c88:	614d2044 	.word	0x614d2044
 8002c8c:	30312079 	.word	0x30312079
 8002c90:	31303220 	.word	0x31303220
 8002c94:	31312038 	.word	0x31312038
 8002c98:	3a37303a 	.word	0x3a37303a
 8002c9c:	000a3633 	.word	0x000a3633

08002ca0 <CSWTCH.2>:
 8002ca0:	50000000 50000000 50000000 50000100     ...P...P...P...P
 8002cb0:	50000100 50000100 50000100 50000400     ...P...P...P...P

08002cc0 <CSWTCH.3>:
 8002cc0:	01040302 0c040302                       ........

08002cc8 <__EH_FRAME_BEGIN__>:
 8002cc8:	00000000                                ....
