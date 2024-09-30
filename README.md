use_debug false #esto deja que que pueda ejecutar el archivos sin parar el audio
use_bpm 120# beats por minutos
#control de volumenes 
v_bat=1
v_prc=0.5
v_amb=1
v_elec=1
v_r=0.25
v_p=0
v_nh=1
live_loop :bateria do # loop bateria 
  sample(ring, :bd_haus,:sn_zome).tick,amp:1*v_bat # alterna entre samples 
  sleep 1 #espera un tiempo
end
prc=[:elec_triangle,:elec_twang,:perc_snap2,:elec_beep,:drum_cowell ] # array de percusion

live_loop :percusion do # bucle 
  sample prc.choose,amp:1*v_prc #uso aleatorio del array
  sleep 1
end

live_loop :ambiente do #loop ambiente
  sample :ambi_soft_buzz, rate:12,amp:1*v_amb
  sleep (ring, 0.5, 1.5, 1).tick # espera  los tiempos en orden
end
live_loop :elec do
  sample :elec_blip,rpitch:(ring,2,5,8,12,17).choose, amp:1*v_elec #cambia el pitch aleatoriamente
  sleep 0.5
end

live_loop:ruido do
  sync:bateria
  with_synth :pnoise do
    play :d1, attack: 0.05, decay: 0.08, release: 0.1, amp:1*v_r,room: 0.6,damp: 0.4 #eco
  end
  use_synth:piano
  live_loop:piano do
    use_random_seed 114
    8.times do
      play scale(64,:minor,num_octaves: 1).tick, amp:1*v_p
      sleep 1
    end
  end
end
live_loop:noise_hats do
  sync:bateria
  with_fx:slicer, mix: 1,phase: 0.25, pulse_width: 0.75,amp:1*v_nh do # mas ruido
    with_fx:hpf, cutoff: 130 do
      with_synth:noise do
        play:d1, decay: 1
      end
    end
  end
  
  
  
  
end
